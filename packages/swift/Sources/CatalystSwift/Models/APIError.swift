// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki
import Foundation

public enum APIError: Error {
  case invalid
  case httpError(statusCode: Int)
  case decodingError(Error)
  case encodingError(Error)
  case unauthorized
}

extension APIError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invalid:
      return "Invalid"

    case .httpError(let statusCode):
      return "HTTP Error: \(statusCode)"

    case .decodingError(let error):
      return "Decoding Error: \(error.localizedDescription)"

    case .encodingError(let error):
      return "Encoding Error: \(error.localizedDescription)"

    case .unauthorized:
      return "Unauthorized"
    }
  }
}
