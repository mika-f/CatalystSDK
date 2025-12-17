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

    let obj: Statuses = try await client.get(
      endpoint: "/catalyst/v1/timeline/home", parameters: parameters)
    return obj.statuses
  }

  public func timelineFirehose(since: String? = nil, until: String? = nil) async throws
    -> [Status]
  {
    var parameters: [String: String] = [:]

    if since != nil {
      parameters["since"] = since
    }
    if until != nil {
      parameters["until"] = until
    }

    let obj: Statuses = try await client.get(
      endpoint: "/catalyst/v1/timeline/firehose", parameters: parameters)
    return obj.statuses
  }

  public func timelineByUser(username: String, since: String? = nil, until: String? = nil)
    async throws -> [Status]
  {
    var parameters: [String: String] = [:]

    if since != nil {
      parameters["since"] = since
    }
    if until != nil {
      parameters["until"] = until
    }

    let obj: Statuses = try await client.get(
      endpoint: "/catalyst/v1/timeline/user/by/username/\(username)", parameters: parameters)
    return obj.statuses
  }

  public func timelineByUserSingle(username: String, since: String? = nil, until: String? = nil)
    async throws -> [Status]
  {
    var parameters: [String: String] = [:]

    if since != nil {
      parameters["since"] = since
    }
    if until != nil {
      parameters["until"] = until
    }

    let obj: Statuses = try await client.get(
      endpoint: "/catalyst/v1/timeline/user/by/username/\(username)/gallery",
      parameters: parameters)
    return obj.statuses
  }

  public func timelineBySearch(
    q: String, exact: Bool? = nil, platformIdentifier: String? = nil, since: String? = nil,
    until: String? = nil
  )
    async throws -> [Status]
  {
    var parameters: [String: String] = [:]
    parameters["q"] = q

    if exact != nil {
      parameters["exact"] = exact! ? "true" : "false"
    }

    if platformIdentifier != nil {
      parameters["platformIdentifier"] = platformIdentifier!
    }

    if since != nil {
      parameters["since"] = since
    }
    if until != nil {
      parameters["until"] = until
    }

    let obj: Statuses = try await client.get(
      endpoint: "/catalyst/v1/timeline/search",
      parameters: parameters)
    return obj.statuses
  }

  public func timelineFavorite(since: String? = nil, until: String? = nil)
    async throws -> [Status]
  {
    var parameters: [String: String] = [:]

    if since != nil {
      parameters["since"] = since
    }

    if until != nil {
      parameters["until"] = until
    }

    let obj: Statuses = try await client.get(
      endpoint: "/catalyst/v1/statuses/favorite", parameters: parameters)
    return obj.statuses
  }

  public func status(by id: String) async throws -> Status {
    return try await client.get(
      endpoint: "/catalyst/v1/status/\(id)", parameters: [:])
  }
  
  public func editStatus(by id: String, body: String) async throws {
    let parameters: [String: String] = [
      "description": body,
      ]
    
    let _: EmptyResponse = try await client.patch(
      endpoint: "/catalyst/v1/status/\(id)", parameters: parameters)
  }

  public func deleteStatus(by id: String) async throws {
    let _: EmptyResponse = try await client.delete(
      endpoint: "/catalyst/v1/status/\(id)", parameters: [:])
  }

  public func reactionsByStatus(id: String) async throws -> [String: Reaction] {
    let obj: ReactionWrapped = try await client.get(
      endpoint: "/catalyst/v1/status/\(id)/reactions", parameters: [:])
    return obj.reactions
  }

  public func incrementReactionByStatus(id: String, symbol: String) async throws -> ReactedValue {
    let obj: ReactedValue = try await client.post(
      endpoint: "/catalyst/v1/status/\(id)/reactions/\(symbol)", parameters: [:])
    return obj
  }

  public func decrementReactionByStatus(id: String, symbol: String) async throws -> ReactedValue {
    let obj: ReactedValue = try await client.delete(
      endpoint: "/catalyst/v1/status/\(id)/reactions/\(symbol)", parameters: [:])
    return obj
  }

  public func isFavorite(by id: String) async throws -> Bool {
    return try await client.get(endpoint: "/catalyst/v1/status/\(id)/favorite", parameters: [:])
  }

  public func favorite(by id: String) async throws {
    let _: EmptyResponse = try await client.post(
      endpoint: "/catalyst/v1/status/\(id)/favorite", parameters: [:])
  }

  public func unfavorite(by id: String) async throws {
    let _: EmptyResponse = try await client.delete(
      endpoint: "/catalyst/v1/status/\(id)/favorite", parameters: [:])
  }

  public func relationships(username: String) async throws -> Relationships {
    return try await client.get(
      endpoint: "/catalyst/v1/relationships/\(username)", parameters: [:])
  }

  public func follow(id: String) async throws {
    let parameters: [String: String] = [
      "userId": id
    ]

    let _: EmptyResponse = try await client.post(
      endpoint: "/catalyst/v1/relationships", parameters: parameters)
  }

  public func unfollow(id: String) async throws {
    let parameters: [String: String] = [
      "userId": id
    ]

    let _: EmptyResponse = try await client.delete(
      endpoint: "/catalyst/v1/relationships", parameters: parameters)
  }

  public func availableReactions() async throws -> [AvailableReaction] {
    let obj: [AvailableReaction] = try await client.get(
      endpoint: "/catalyst/v1/reactions", parameters: [:])
    return obj
  }

  public func getMediaUploadUrl() async throws -> MediaUploadUrl {
    return try await client.post(endpoint: "/media/v2/upload", parameters: [:])
  }
}
