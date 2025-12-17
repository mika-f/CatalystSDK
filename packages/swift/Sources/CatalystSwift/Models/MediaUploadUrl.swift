// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct MediaUploadUrl: Codable, Equatable, Hashable, Sendable {
  public let url: String
  public let signedUrl: String
}
