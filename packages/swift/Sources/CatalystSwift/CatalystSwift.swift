// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public final class CatalystSwift {
    let clientId: String
    let clientSecret: String
    var accessToken: String?
    var refreshToken: String?

    public required init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    public convenience init(clientId: String, clientSecret: String, accessToken: String, refreshToken: String) {
        self.init(clientId: clientId, clientSecret: clientSecret)
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }

    public lazy var oauth: OAuth = .init(client: self)
    public lazy var egeria: Egeria = .init(client: self)
    public lazy var status: Statuses = .init(client: self)
}
