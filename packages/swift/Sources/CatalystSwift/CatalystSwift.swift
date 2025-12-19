// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public enum CatalystSwiftError: Error {
  // response cause
  case BadRequestException  // 400
  case UnauthorizedException  // 401
  case InternalServerErrorException  // 500
  case UncaughtServerErrorException(HTTPErrorInfo)  // xxx

  // request cause
  case InvalidRequestException
}

struct HTTPServerError: Codable {
  let message: String?
}

public struct HTTPErrorInfo: Codable, Sendable {
  let message: String
  let code: Int
}

public final actor CatalystSwift {
  private var initialInterceptors: [RequestInterceptor] = []
  public let clientId: String
  public let clientSecret: String
  public private(set) var accessToken: String?
  public private(set) var refreshToken: String?

  private lazy var client: APIClient = {
    var interceptors = initialInterceptors
    interceptors.append(AuthInterceptor(tokenProvider: { [weak self] in await self?.accessToken }))
    interceptors.append(UserAgentInterceptor())
    return URLSessionAPIClient(interceptors: interceptors)
  }()

  public init(clientId: String, clientSecret: String, interceptors: [RequestInterceptor] = []) {
    self.clientId = clientId
    self.clientSecret = clientSecret
    self.initialInterceptors = interceptors
  }

  public init(
    clientId: String, clientSecret: String, accessToken: String, refreshToken: String,
    interceptors: [RequestInterceptor] = []
  ) {
    self.clientId = clientId
    self.clientSecret = clientSecret
    self.accessToken = accessToken
    self.refreshToken = refreshToken
    self.initialInterceptors = interceptors
  }

  public func setCredential(accessToken: String, refreshToken: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }

  public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
    try await client.request(endpoint)
  }

  public func request(_ endpoint: Endpoint) async throws {
    try await client.request(endpoint)
  }

  public func requestRaw(_ endpoint: Endpoint) async throws -> Data {
    try await client.requestRaw(endpoint)
  }

  public func refresh() async throws -> Token {
    guard let refreshToken else {
      fatalError("refreshToken is nil")
    }

    let token = try await oauth.getAccessTokenByRefreshToken(using: refreshToken)
    accessToken = token.accessToken
    self.refreshToken = token.refreshToken

    return token
  }

  // for notifications parser
  public static func decode<T: Decodable>(_ data: Data) throws -> T {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.iso8601Full)
    return try decoder.decode(T.self, from: data)
  }

  public var oauth: OAuth { .init(client: self) }
  public var catalyst: CatalystClient { .init(client: self) }
  public var egeria: EgeriaClient { .init(client: self) }
  public var media: MediaClient { .init(client: self) }
  public var steambird: SteambirdClient { .init(client: self) }
}
