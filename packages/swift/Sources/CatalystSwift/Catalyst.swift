// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public final class Catalyst: Sendable {
    private let client: CatalystSwift

    init(client: CatalystSwift) {
        self.client = client
    }

    public func timelineHome(since: String? = nil, until: String? = nil) async throws -> [Status] {
        var parameters: [String: String] = [:]

        if since != nil {
            parameters["since"] = since
        }
        if until != nil {
            parameters["until"] = until
        }

        let obj: Statuses = try await client.get(endpoint: "/catalyst/v1/timeline/home", parameters: parameters)
        return obj.statuses
    }

    public func timelineFirehose(since: String? = nil, until: String? = nil) async throws -> [Status] {
        var parameters: [String: String] = [:]

        if since != nil {
            parameters["since"] = since
        }
        if until != nil {
            parameters["until"] = until
        }

        let obj: Statuses = try await client.get(endpoint: "/catalyst/v1/timeline/firehose", parameters: parameters)
        return obj.statuses
    }

    public func relationships(username: String) async throws -> Relationships {
        return try await client.get(endpoint: "/catalyst/v1/relationships/\(username)", parameters: [:])
    }
}
