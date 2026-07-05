// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// Client for Feature Flags API endpoints.
public final class FeatureFlagsClient: Sendable {
  private let client: CatalystSwift

  init(client: CatalystSwift) {
    self.client = client
  }

  /// Gets the feature flags enabled for the current user.
  public func me() async throws -> [String] {
    let response: CatalystFeatureFlags = try await client.request(FeatureFlagsEndpoint.me)
    return response.flags
  }
}
