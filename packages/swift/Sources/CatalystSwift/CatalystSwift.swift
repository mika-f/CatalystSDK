// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public final class CatalystSwift {
    internal let clientId: String
    internal let clientSecret: String
    internal var accessToken: String?
    internal var refreshToken: String?

    public required init(clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
    public convenience init(clientId: String, clientSecret: String, accessToken: String, refreshToken: String) {
        self.init(clientId: clientId, clientSecret: clientSecret)
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }

    
    public lazy var oauth: OAuth = OAuth(client: self)
    
    public lazy var status: Statuses = Statuses(client: self)
}
