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

/// The current user's remaining vote allowance for a contest.
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
