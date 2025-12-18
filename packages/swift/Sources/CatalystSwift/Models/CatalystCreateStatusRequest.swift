// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystCreateStatusRequest: Encodable, Sendable {
  public let description: String
  public let isNsfw: Bool
  public let isSpoiler: Bool
  public let isSubmitToContest: Bool
  public let isHidingLikeAndViewCount: Bool
  public let isPrivateMetadata: Bool?
  public let isAllowComments: Bool
  public let privacy: CatalystStatusPrivacy?
  public let contestId: String?
  public let media: [CatalystMediaWithMetadata]
}
