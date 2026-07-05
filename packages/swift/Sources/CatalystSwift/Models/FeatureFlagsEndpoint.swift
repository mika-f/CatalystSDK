// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum FeatureFlagsEndpoint: Endpoint {
  case me

  public var path: String {
    switch self {
    case .me:
      return "/feature-flags/v1/me"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .me:
      return .get
    }
  }

  public var headers: [String: String]? {
    return nil
  }

  public var queryParameters: [String: String]? {
    return nil
  }

  public var body: Encodable? {
    return nil
  }
}
