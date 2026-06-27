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

  public func requestMultipart<T: Decodable>(_ path: String, fields: [String: String], imageKey: String, imageData: Data, mimeType: String) async throws -> T {
    let boundary = UUID().uuidString
    var body = Data()

    for (key, value) in fields {
      body.append("--\(boundary)\r\n".data(using: .utf8)!)
      body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
      body.append("\(value)\r\n".data(using: .utf8)!)
    }

    let ext = mimeType == "image/jpeg" ? "jpg" : "png"
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"\(imageKey)\"; filename=\"reaction.\(ext)\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
    body.append(imageData)
    body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

    let url = URL(string: PUBLIC_API_ENDPOINT)!.appendingPathComponent(path)
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    request.httpBody = body

    for interceptor in initialInterceptors {
      request = try await interceptor.adapt(request)
    }
    if let token = accessToken {
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }

    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
      throw APIError.invalid
    }
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.iso8601Full)
    return try decoder.decode(T.self, from: data)
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
