// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public final class Steambird: Sendable {
    private let client: CatalystSwift

    public let ISSUER_CATALYST_SYSTEM_MESSAGE = "natsuneko-laboratory:catalyst"
    public let ISSUER_CATALYST_USER_MESSAGE = "natsuneko-laboratory:catalyst-message"
    public let ISSUER_EGERIA_SYSTEM_MESSAGE = "natsuneko-laboratory:egeria"

    init(client: CatalystSwift) {
        self.client = client
    }

    public func fetchByIssuer(issuer: String, since: String? = nil, until: String? = nil) async throws -> [Notification] {
        var parameters: [String: String] = [
            "issuer": issuer,
        ]

        if let since = since {
            parameters["since"] = since
        }
        if let until = until {
            parameters["until"] = until
        }

        let wrapped: Notifications = try await client.get(endpoint: "/steambird/v1/notifications", parameters: parameters)
        return wrapped.notifications
    }
}
