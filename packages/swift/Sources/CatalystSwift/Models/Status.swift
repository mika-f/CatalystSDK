// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public struct Status: Codable, Sendable {
    public let id: String
    public let body: String
    public let createdAt: Date
    public let user: User
    public let medias: [Media]
}
