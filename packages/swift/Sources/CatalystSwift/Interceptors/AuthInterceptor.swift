// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki
import Foundation

final class AuthInterceptor: RequestInterceptor {
  private let tokenProvider: @Sendable () async throws -> String?
  private let retryManager = RetryManager()

  init(tokenProvider: @escaping @Sendable () async throws -> String?) {
    self.tokenProvider = tokenProvider
  }

  func adapt(_ request: URLRequest) async throws -> URLRequest {
    var request = request
    let token = try await self.tokenProvider()

    if let token = token {
      request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
    }

    return request
  }

  func retry(_ request: URLRequest, with error: any Error) async throws -> Bool {
    guard case APIError.httpError(let statusCode) = error, statusCode == 401 else {
      return false
    }

    return await retryManager.shouldRetry(for: request)
  }
}

private actor RetryManager {
  private let maxRetryCount = 5
  private var retryCounts: [String: Int] = [:]

  func shouldRetry(for request: URLRequest) -> Bool {
    let key = makeRequestKey(from: request)
    let currentCount = retryCounts[key, default: 0]

    if currentCount >= maxRetryCount {
      retryCounts.removeValue(forKey: key)
      return false
    }

    retryCounts[key] = currentCount + 1
    return true
  }

  private func makeRequestKey(from request: URLRequest) -> String {
    let url = request.url?.absoluteString ?? ""
    let method = request.httpMethod ?? "GET"
    return "\(method):\(url)"
  }
}
