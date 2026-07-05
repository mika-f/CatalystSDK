// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// Generic `{"result": boolean}` response shape used by many mutation endpoints.
public struct CatalystResult: Decodable, Sendable, Equatable, Hashable {
  public let result: Bool
}

/// Generic `{"value": number}` response shape used by reaction toggle endpoints.
public struct CatalystReactionValue: Decodable, Sendable, Equatable, Hashable {
  public let value: Int
}

/// Generic `{"message": string}` response shape.
public struct CatalystMessage: Decodable, Sendable, Equatable, Hashable {
  public let message: String
}
