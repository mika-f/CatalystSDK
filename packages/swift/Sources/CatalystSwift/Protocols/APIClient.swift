// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

protocol APIClient: Sendable {
  func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
  func request(_ endpoint: Endpoint) async throws
  func requestRaw(_ endpoint: Endpoint) async throws -> Data
}
