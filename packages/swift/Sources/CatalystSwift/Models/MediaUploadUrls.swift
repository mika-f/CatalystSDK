// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct MediaUploadUrls: Decodable, Sendable {
  public let url: String
  public let signedUrl: String
}
