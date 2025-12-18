// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki
import Foundation

public protocol Endpoint: Sendable {
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String]? { get }
  var queryParameters: [String: String]? { get }
  var body: Encodable? { get }
}

let baseURL = URL(string: PUBLIC_API_ENDPOINT)!

extension Endpoint {
  var request: URLRequest {
    var url = baseURL.appendingPathComponent(path)

    if let queryParameters = queryParameters {
      var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
      components?.queryItems = queryParameters.map {
        URLQueryItem(name: $0.key, value: $0.value)
      }

      url = components?.url ?? url
    }

    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

    if let body = body {
      request.httpBody = try? JSONEncoder().encode(body)
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }

    return request
  }
}
