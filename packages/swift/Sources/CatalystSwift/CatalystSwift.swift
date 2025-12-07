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

public actor CatalystSwift {
  let clientId: String
  let clientSecret: String
  var accessToken: String?
  var refreshToken: String?

  public init(clientId: String, clientSecret: String) {
    self.clientId = clientId
    self.clientSecret = clientSecret
  }

  public init(clientId: String, clientSecret: String, accessToken: String, refreshToken: String) {
    self.clientId = clientId
    self.clientSecret = clientSecret
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }

  public func setCredential(accessToken: String, refreshToken: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
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

  public func get<T>(endpoint: String, parameters: [String: String]) async throws -> T
  where T: Decodable, T: Sendable {
    var components = URLComponents(string: PUBLIC_API_ENDPOINT + endpoint)!

    if !parameters.isEmpty {
      components.queryItems = []

      for (key, value) in parameters {
        components.queryItems?.append(URLQueryItem(name: key, value: value))
      }
    }

    let url = components.url!
    var req = URLRequest(url: url)
    req.httpMethod = "GET"
    req.setValue("application/json", forHTTPHeaderField: "content-type")
    req.setValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "authorization")

    let (payload, response) = try await URLSession.shared.data(for: req)
    guard let status = (response as? HTTPURLResponse)?.statusCode else {
      throw CatalystSwiftError.InvalidRequestException
    }

    let json: T = try ensureUnsuccessStatusCode(status, payload: payload)
    return json
  }

  public func post<T>(endpoint: String, parameters: [String: String]) async throws -> T
  where T: Decodable, T: Sendable {
    var components = URLComponents(string: PUBLIC_API_ENDPOINT + endpoint)!

    if !parameters.isEmpty {
      components.queryItems = []

      for (key, value) in parameters {
        components.queryItems?.append(URLQueryItem(name: key, value: value))
      }
    }

    let url = components.url!
    let body = try JSONSerialization.data(withJSONObject: parameters, options: [])
    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "content-type")
    req.setValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "authorization")
    req.httpBody = body

    let (payload, response) = try await URLSession.shared.data(for: req)
    guard let status = (response as? HTTPURLResponse)?.statusCode else {
      throw CatalystSwiftError.InvalidRequestException
    }

    let json: T = try ensureUnsuccessStatusCode(status, payload: payload)
    return json
  }

  public func put<T>(endpoint: String, parameters: [String: String]) async throws -> T
  where T: Decodable, T: Sendable {
    var components = URLComponents(string: PUBLIC_API_ENDPOINT + endpoint)!

    if !parameters.isEmpty {
      components.queryItems = []

      for (key, value) in parameters {
        components.queryItems?.append(URLQueryItem(name: key, value: value))
      }
    }

    let url = components.url!
    let body = try JSONSerialization.data(withJSONObject: parameters, options: [])
    var req = URLRequest(url: url)
    req.httpMethod = "PUT"
    req.setValue("application/json", forHTTPHeaderField: "content-type")
    req.setValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "authorization")
    req.httpBody = body

    let (payload, response) = try await URLSession.shared.data(for: req)
    guard let status = (response as? HTTPURLResponse)?.statusCode else {
      throw CatalystSwiftError.InvalidRequestException
    }

    let json: T = try ensureUnsuccessStatusCode(status, payload: payload)
    return json
  }

  public func patch<T>(endpoint: String, parameters: [String: String]) async throws -> T
  where T: Decodable, T: Sendable {
    var components = URLComponents(string: PUBLIC_API_ENDPOINT + endpoint)!

    if !parameters.isEmpty {
      components.queryItems = []

      for (key, value) in parameters {
        components.queryItems?.append(URLQueryItem(name: key, value: value))
      }
    }

    let url = components.url!
    let body = try JSONSerialization.data(withJSONObject: parameters, options: [])
    var req = URLRequest(url: url)
    req.httpMethod = "PATCH"
    req.setValue("application/json", forHTTPHeaderField: "content-type")
    req.setValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "authorization")
    req.httpBody = body

    let (payload, response) = try await URLSession.shared.data(for: req)
    guard let status = (response as? HTTPURLResponse)?.statusCode else {
      throw CatalystSwiftError.InvalidRequestException
    }

    let json: T = try ensureUnsuccessStatusCode(status, payload: payload)
    return json
  }

  public func delete<T>(endpoint: String, parameters: [String: String]) async throws -> T
  where T: Decodable, T: Sendable {
    var components = URLComponents(string: PUBLIC_API_ENDPOINT + endpoint)!

    if !parameters.isEmpty {
      components.queryItems = []

      for (key, value) in parameters {
        components.queryItems?.append(URLQueryItem(name: key, value: value))
      }
    }

    let url = components.url!
    let body = try JSONSerialization.data(withJSONObject: parameters, options: [])
    var req = URLRequest(url: url)
    req.httpMethod = "delete"
    req.setValue("application/json", forHTTPHeaderField: "content-type")
    req.setValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "authorization")
    req.httpBody = body

    let (payload, response) = try await URLSession.shared.data(for: req)
    guard let status = (response as? HTTPURLResponse)?.statusCode else {
      throw CatalystSwiftError.InvalidRequestException
    }

    let json: T = try ensureUnsuccessStatusCode(status, payload: payload)
    return json
  }

  private func ensureUnsuccessStatusCode<T>(_ status: Int, payload: Data) throws -> T
  where T: Decodable {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.iso8601Full)

    if status == 200 {
      let obj = try! decoder.decode(T.self, from: payload)
      return obj
    } else {
      let obj = try! decoder.decode(HTTPServerError.self, from: payload)
      switch status {
      case 400:
        throw CatalystSwiftError.InvalidRequestException

      case 401:
        throw CatalystSwiftError.UnauthorizedException

      case 500:
        throw CatalystSwiftError.InternalServerErrorException

      default:
        throw CatalystSwiftError.UncaughtServerErrorException(
          HTTPErrorInfo(message: obj.message ?? "", code: status))
      }
    }
  }

  // for notifications parser
  public static func decode<T: Decodable>(_ data: Data) throws -> T {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.iso8601Full)
    return try decoder.decode(T.self, from: data)
  }

  public lazy var oauth: OAuth = .init(client: self)
  public lazy var catalyst: Catalyst = .init(client: self)
  public lazy var egeria: Egeria = .init(client: self)
  public lazy var steambird: Steambird = .init(client: self)
}
