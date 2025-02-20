// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct User: Codable {
    public let id: String
    public let screenName: String
    public let displayName: String
    public let profile: UserProfile
}
