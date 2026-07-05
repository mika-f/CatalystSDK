// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// Request body for `POST /catalyst/v1/statuses/reactions`.
public struct CatalystBulkStatusReactionsRequest: Encodable, Sendable {
  public let ids: [String]

  public init(ids: [String]) {
    self.ids = ids
  }
}

/// Wrapper for the `{"reactions": {statusId: {symbol: Reaction}}}` response shape returned by
/// `POST /catalyst/v1/statuses/reactions`.
public struct CatalystBulkStatusReactions: Decodable, Sendable {
  public let reactions: [String: [String: CatalystReaction]]
}
