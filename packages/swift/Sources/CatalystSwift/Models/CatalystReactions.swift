// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystReactions: Decodable, Sendable, Equatable, Hashable {
  public let reactions: [String: CatalystReaction]
}
