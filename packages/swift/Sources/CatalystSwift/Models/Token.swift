// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct Token: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let tokenType: String
}
