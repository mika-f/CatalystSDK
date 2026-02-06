// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public final class MediaClient: Sendable {
  private let client: CatalystSwift

  init(client: CatalystSwift) {
    self.client = client
  }

  public func download(data: MediaDownloadRequest) async throws -> Data {
    return try await client.requestRaw(MediaEndpoint.download(data: data))
  }

  public func delete(data: MediaDeleteRequest) async throws {
    try await client.request(MediaEndpoint.delete(data: data))
  }

  public func upload() async throws -> MediaUploadUrls {
    return try await client.request(MediaEndpoint.upload)
  }
}
