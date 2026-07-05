// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// Wrapper for the `{"flags": [...]}` response shape.
public struct CatalystFeatureFlags: Decodable, Sendable {
  public let flags: [String]
}
