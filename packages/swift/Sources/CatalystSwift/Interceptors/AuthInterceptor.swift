// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki
import Foundation

final class AuthInterceptor: RequestInterceptor {
  private let tokenProvider: () async throws -> String?

  init(tokenProvider: @escaping () async throws -> String?) {
    self.tokenProvider = tokenProvider
  }

  func adapt(_ request: URLRequest) async throws -> URLRequest {
    var request = request
    let token = try await self.tokenProvider()

    if let token = token {
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }

    return request
  }

  func retry(_ request: URLRequest, with error: any Error) async throws -> Bool {
    guard case APIError.httpError(let statusCode) = error, statusCode == 401 else {
      return false
    }

    return true
  }
}
