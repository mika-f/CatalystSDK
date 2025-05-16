// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public struct Relationships: Codable, Sendable {
    public let isMyself: Bool
    public let isFollowing: Bool
    public let isFollowed: Bool
}
