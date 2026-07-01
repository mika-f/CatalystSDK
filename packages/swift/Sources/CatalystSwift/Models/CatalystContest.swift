// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public enum CatalystContestState: String, Codable, Sendable, Equatable, Hashable {
  case draft
  case published
  case opening
  case closing
  case voting
  case electing
  case closed
}

public struct CatalystContestVoting: Decodable, Sendable, Equatable, Hashable {
  /// ISO8601 string, or empty when unset.
  public let since: String
  /// ISO8601 string, or empty when unset.
  public let until: String
  public let maxVotes: Int
  public let isEnable: Bool
}

public struct CatalystContestRank: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let name: String
  public let description: String?
  public let count: Int
  public let prize: String
  public let winners: [EgeriaUser]
}

public struct CatalystContest: Decodable, Sendable, Equatable, Hashable {
  public let slug: String
  public let draft: Bool
  public let state: CatalystContestState
  public let title: String
  public let description: String
  public let theme: String
  public let terms: String
  public let headerUrl: String
  public let bannerUrl: String
  public let organizer: EgeriaUser
  /// ISO8601 string, or empty when unset.
  public let winnersOpenAt: String
  /// ISO8601 string, or empty when unset.
  public let winnersMessageSendAt: String
  /// ISO8601 string, or empty when unset.
  public let publishedAt: String
  /// ISO8601 string, or empty when unset.
  public let since: String
  /// ISO8601 string, or empty when unset.
  public let until: String
  public let allowSensitive: Bool
  public let maxMediaPerEntry: Int?
  public let voting: CatalystContestVoting
  public let ranks: [CatalystContestRank]
}

public struct CatalystContestAwardAttachment: Decodable, Sendable, Equatable, Hashable {
  public let name: String
  public let id: String
}

public struct CatalystContestAwardWinner: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let body: String
  public let user: EgeriaUser?
  public let medias: [Media]
  public let contest: CatalystStatusContest?
  public let createdAt: Date

  /// - Deprecated: The real API always serializes this as an empty array; contents are not modeled.
  public let reactions: [String]?

  public let message: String?
  public let commentary: String?
  public let attachment: CatalystContestAwardAttachment?
}

public struct CatalystContestAward: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let name: String
  public let winners: [CatalystContestAwardWinner]
  public let order: Int
  public let count: Int
  public let remaining: Int
}

public enum CatalystContestCollaboratorRole: String, Codable, Sendable, Equatable, Hashable {
  case admin
  case collaborator
  case contributor
}

public struct CatalystContestCollaborator: Decodable, Sendable, Equatable, Hashable {
  public let user: EgeriaUser
  public let role: CatalystContestCollaboratorRole
}

public struct CatalystContestPoll: Decodable, Sendable, Equatable, Hashable {
  public let status: CatalystStatus
  public let count: Int
}

public struct CatalystUserVoteRights: Decodable, Sendable, Equatable, Hashable {
  public let remaining: Int
  public let statuses: [String]
}

public struct CatalystContestWrapper: Decodable, Sendable {
  public let contest: CatalystContest
}

public struct CatalystContestsWrapper: Decodable, Sendable {
  public let contests: [CatalystContest]
}

public struct CatalystContestAwardsWrapper: Decodable, Sendable {
  public let awards: [CatalystContestAward]
}

public struct CatalystContestCollaboratorsWrapper: Decodable, Sendable {
  public let collaborators: [CatalystContestCollaborator]
}

public struct CatalystContestPollsWrapper: Decodable, Sendable {
  public let polls: [CatalystContestPoll]
}

public struct CatalystContestAccessPermission: Decodable, Sendable, Equatable, Hashable {
  /// One of "admin", "collaborator", "contributor", "guest".
  public let result: String
}
