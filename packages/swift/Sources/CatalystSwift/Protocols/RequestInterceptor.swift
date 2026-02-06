// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki
import Foundation

public protocol RequestInterceptor: Sendable {
  func adapt(_ request: URLRequest) async throws -> URLRequest
  func retry(_ request: URLRequest, with error: Error) async throws -> Bool
}
