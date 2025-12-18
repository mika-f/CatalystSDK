// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki
import Foundation

final class URLSessionAPIClient: APIClient {
  private let session: URLSession = .shared
  private let interceptors: [RequestInterceptor]

  init(interceptors: [RequestInterceptor] = []) {
    self.interceptors = interceptors
  }

  func request<T: Sendable>(_ endpoint: Endpoint) async throws -> T where T: Decodable {
    var request = endpoint.request

    for interceptor in interceptors {
      request = try await interceptor.adapt(request)
    }

    let (data, response) = try await session.data(for: endpoint.request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw APIError.invalid
    }

    guard (200...299).contains(httpResponse.statusCode) else {
      let error = APIError.httpError(statusCode: httpResponse.statusCode)

      for interceptor in interceptors {
        if try await interceptor.retry(request, with: error) {
          return try await self.request(endpoint)
        }
      }

      throw error
    }

    do {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .formatted(.iso8601Full)
      return try decoder.decode(T.self, from: data)
    } catch {
      throw APIError.decodingError(error)
    }
  }

  func request(_ endpoint: Endpoint) async throws {
    var request = endpoint.request

    for interceptor in interceptors {
      request = try await interceptor.adapt(request)
    }

    let (_, response) = try await session.data(for: endpoint.request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw APIError.invalid
    }

    guard (200...299).contains(httpResponse.statusCode) else {
      let error = APIError.httpError(statusCode: httpResponse.statusCode)

      for interceptor in interceptors {
        if try await interceptor.retry(request, with: error) {
          return try await self.request(endpoint)
        }
      }

      throw error
    }
  }

  func requestRaw(_ endpoint: Endpoint) async throws -> Data {
    var request = endpoint.request

    for interceptor in interceptors {
      request = try await interceptor.adapt(request)
    }

    let (data, response) = try await session.data(for: endpoint.request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw APIError.invalid
    }

    guard (200...299).contains(httpResponse.statusCode) else {
      let error = APIError.httpError(statusCode: httpResponse.statusCode)

      for interceptor in interceptors {
        if try await interceptor.retry(request, with: error) {
          return try await self.request(endpoint)
        }
      }

      throw error
    }
    
    return data
  }
}
