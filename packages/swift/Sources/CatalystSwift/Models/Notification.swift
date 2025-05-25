// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct NotificationGroupEntity: Codable, Equatable, Hashable, Sendable {
    public let id: String
    public let body: String
    public let occurredBy: User
    public let isRead: Bool
}

public struct Notification: Decodable, @unchecked Sendable {
    public let id: String
    public let title: String
    public let isGrouped: Bool
    public let belongsTo: [String: Any]
    public let entities: [NotificationGroupEntity]
    public let hasMore: Bool
    public let read: Bool

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case isGrouped
        case entities
        case hasMore
        case read
        case belongsTo
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        isGrouped = try container.decode(Bool.self, forKey: .isGrouped)
        entities = try container.decode([NotificationGroupEntity].self, forKey: .entities)
        hasMore = try container.decode(Bool.self, forKey: .hasMore)
        read = try container.decode(Bool.self, forKey: .read)
        belongsTo = try container.decode([String: Any].self, forKey: .belongsTo)
    }
}

public struct Notifications: Decodable, Sendable {
    public let notifications: [Notification]
}
