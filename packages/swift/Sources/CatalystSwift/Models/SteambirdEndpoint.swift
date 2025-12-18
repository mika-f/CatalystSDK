// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum SteambirdEndpoint: Endpoint {
  case notifications(issuer: String)
  case read(id: String)
  case readAll(issuer: String?)
  case unreads(issuers: [String]?)

  public var path: String {
    switch self {
    case .notifications:
      return "/steambird/v1/notifications"

    case .read(let id):
      return "/steambird/v1/notifications/\(id)"

    case .readAll:
      return "/steambird/v1/notifications/all"

    case .unreads:
      return "/steambird/v1/notifications/unread"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .notifications:
    case .unreads:
      return .get

    case .read:
    case .readAll:
      return .post
    }
  }

  public var headers: [String: String]? {
    switch self {
    default:
      return nil
    }
  }

  public var queryParameters: [String: String]? {
    switch self {
    case .notifications(let issuer):
      let params: [String: String] = [
        "issuer": issuer
      ]

      return params

    case .readAll(let issuer):
      let params: [String: String] = issuer.map { ["issuer": $0] } ?? [:]
      return params

    case .unreads(let issuers):
      let params: [String: String] = issuers.map { ["issuers": $0.joined(separator: ",")] } ?? [:]
      return params

    default:
      return nil
    }
  }

  public var body: (any Encodable)? {
    switch self {
    default:
      return nil
    }
  }
}
