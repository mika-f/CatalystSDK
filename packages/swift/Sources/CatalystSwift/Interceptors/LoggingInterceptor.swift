// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

final class LoggingInterceptor: RequestInterceptor {
  func adapt(_ request: URLRequest) async throws -> URLRequest {
    print("➡️ \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
    if let headers = request.allHTTPHeaderFields {
      print("  headers: \(headers)")
    }

    if let body = request.httpBody,
      let json = try? JSONSerialization.jsonObject(with: body)
    {
      print("  body: \(json)")
    }

    return request
  }

  func retry(_ request: URLRequest, with error: Error) async throws -> Bool {
    print("❌ Request failed: \(error.localizedDescription)")
    return false
  }
}
