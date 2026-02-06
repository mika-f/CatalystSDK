// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public struct CatalystSmartAlbum: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let name: String
  public let description: String
  public let isAllowNsfw: Bool
  public let isAllowOthers: Bool
  public let since: Date?
  public let until: Date?
  public let isPublic: Bool
  public let mode: CatalystAlbumDisplayMode
  public let user: EgeriaUser?
  public let type: String?
  public let statuses: [CatalystStatus]
  public let hashtags: [String]

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case isAllowNsfw
    case isAllowOthers
    case since
    case until
    case isPublic
    case mode
    case user
    case type
    case statuses
    case hashtags
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(String.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    description = try container.decode(String.self, forKey: .description)
    isAllowNsfw = try container.decode(Bool.self, forKey: .isAllowNsfw)
    isAllowOthers = try container.decode(Bool.self, forKey: .isAllowOthers)
    isPublic = try container.decode(Bool.self, forKey: .isPublic)
    mode = try container.decode(CatalystAlbumDisplayMode.self, forKey: .mode)
    user = try container.decodeIfPresent(EgeriaUser.self, forKey: .user)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    statuses = try container.decode([CatalystStatus].self, forKey: .statuses)
    hashtags = try container.decode([String].self, forKey: .hashtags)

    // Handle flexible date decoding
    since = try? container.decodeIfPresent(Date.self, forKey: .since)
    until = try? container.decodeIfPresent(Date.self, forKey: .until)
  }
}
