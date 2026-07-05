// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// Privacy settings for the current user's following/follower lists.
///
/// `followingListVisibility` and `followerListVisibility` are one of "public" | "private".
/// GET and PATCH `/catalyst/v1/privacy/settings` share this same shape for request and response.
public struct CatalystPrivacySettings: Codable, Sendable, Equatable, Hashable {
  public let followingListVisibility: String
  public let followerListVisibility: String

  public init(followingListVisibility: String, followerListVisibility: String) {
    self.followingListVisibility = followingListVisibility
    self.followerListVisibility = followerListVisibility
  }
}
