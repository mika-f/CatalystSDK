// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystStatuses: Decodable, Sendable {
  public let statuses: [CatalystStatus]
}

/// Wrapper for the `{"statuses": [...]}` response shape (v1.1 shape), used by
/// `GET /catalyst/v1/timeline/favorite`.
public struct CatalystStatusesV1_1: Decodable, Sendable {
  public let statuses: [CatalystStatusV1_1]
}
