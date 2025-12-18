// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum MediaEndpoint: Endpoint {
  case download(data: MediaDownloadRequest)
  case delete(data: MediaDeleteRequest)
  case upload

  public var path: String {
    switch self {
    case .download:
      return "/media/v1/download"

    case .delete:
      return "/media/v1/upload"

    case .upload:
      return "/media/v2/upload"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .download, .upload:
      return .post

    case .delete:
      return .delete
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
    default:
      return nil
    }
  }

  public var body: (any Encodable)? {
    switch self {
    case .download(let data):
      return data

    case .delete(let data):
      return data

    default:
      return nil
    }
  }
}
