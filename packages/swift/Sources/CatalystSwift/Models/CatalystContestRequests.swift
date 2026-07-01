// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystCreateContestRequest: Encodable, Sendable {
  public let title: String
  public let description: String
  public let theme: String

  public init(title: String, description: String, theme: String) {
    self.title = title
    self.description = description
    self.theme = theme
  }
}

public struct CatalystContestApplicationRequest: Encodable, Sendable {
  public let since: String?
  public let until: String?
  public let allowSensitive: Bool
  public let maxMediaPerEntry: Int?

  public init(
    since: String? = nil, until: String? = nil, allowSensitive: Bool,
    maxMediaPerEntry: Int? = nil
  ) {
    self.since = since
    self.until = until
    self.allowSensitive = allowSensitive
    self.maxMediaPerEntry = maxMediaPerEntry
  }
}

public struct CatalystContestVotingRequest: Encodable, Sendable {
  public let since: String?
  public let until: String?
  public let maxVotes: Int?
  public let isEnableVoting: Bool?

  public init(
    since: String? = nil, until: String? = nil, maxVotes: Int? = nil,
    isEnableVoting: Bool? = nil
  ) {
    self.since = since
    self.until = until
    self.maxVotes = maxVotes
    self.isEnableVoting = isEnableVoting
  }
}

public struct CatalystContestWinnersRequest: Encodable, Sendable {
  public let since: String?
  public let until: String?

  public init(since: String? = nil, until: String? = nil) {
    self.since = since
    self.until = until
  }
}

public struct CatalystEditContestRankRequest: Encodable, Sendable {
  public let name: String
  public let description: String?
  public let count: Int
  public let prize: String

  public init(name: String, description: String? = nil, count: Int, prize: String) {
    self.name = name
    self.description = description
    self.count = count
    self.prize = prize
  }
}

public struct CatalystEditContestRequest: Encodable, Sendable {
  public let title: String?
  public let description: String?
  public let theme: String?
  public let terms: String?
  public let headerUrl: String?
  public let bannerUrl: String?
  public let winnersOpenAt: String?
  public let winnersMessageSendAt: String?
  public let publishedAt: String?
  public let application: CatalystContestApplicationRequest?
  public let voting: CatalystContestVotingRequest?
  public let winners: CatalystContestWinnersRequest?
  public let ranks: [CatalystEditContestRankRequest]?

  public init(
    title: String? = nil,
    description: String? = nil,
    theme: String? = nil,
    terms: String? = nil,
    headerUrl: String? = nil,
    bannerUrl: String? = nil,
    winnersOpenAt: String? = nil,
    winnersMessageSendAt: String? = nil,
    publishedAt: String? = nil,
    application: CatalystContestApplicationRequest? = nil,
    voting: CatalystContestVotingRequest? = nil,
    winners: CatalystContestWinnersRequest? = nil,
    ranks: [CatalystEditContestRankRequest]? = nil
  ) {
    self.title = title
    self.description = description
    self.theme = theme
    self.terms = terms
    self.headerUrl = headerUrl
    self.bannerUrl = bannerUrl
    self.winnersOpenAt = winnersOpenAt
    self.winnersMessageSendAt = winnersMessageSendAt
    self.publishedAt = publishedAt
    self.application = application
    self.voting = voting
    self.winners = winners
    self.ranks = ranks
  }
}

public struct CatalystSetContestAwardRequest: Encodable, Sendable {
  public let status: String
  public let message: String?
  public let commentary: String?

  public init(status: String, message: String? = nil, commentary: String? = nil) {
    self.status = status
    self.message = message
    self.commentary = commentary
  }
}

public struct CatalystUnsetContestAwardRequest: Encodable, Sendable {
  public let status: String
  public let message: String?
  public let commentary: String?

  public init(status: String, message: String? = nil, commentary: String? = nil) {
    self.status = status
    self.message = message
    self.commentary = commentary
  }
}

public struct CatalystContestAddCollaboratorRequest: Encodable, Sendable {
  public let userId: String
  /// One of "collaborator" or "contributor".
  public let role: String

  public init(userId: String, role: String) {
    self.userId = userId
    self.role = role
  }
}

public struct CatalystContestRemoveCollaboratorRequest: Encodable, Sendable {
  public let userId: String

  public init(userId: String) {
    self.userId = userId
  }
}
