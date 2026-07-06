// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public final class MediaClient: Sendable {
  private let client: CatalystSwift

  init(client: CatalystSwift) {
    self.client = client
  }

  /// Gets a signed URL for uploading media (v1).
  public func uploadV1() async throws -> MediaUploadUrls {
    return try await client.request(MediaEndpoint.uploadV1)
  }

  /// Downloads media by URL.
  ///
  /// Not documented in the current OpenAPI spec, but still supported by the live API.
  public func download(data: MediaDownloadRequest) async throws -> Data {
    return try await client.requestRaw(MediaEndpoint.download(data: data))
  }

  /// Deletes media by URL.
  public func delete(url: String) async throws -> Bool {
    return try await client.request(MediaEndpoint.delete(data: MediaDeleteRequest(url: url)))
  }

  /// Gets a signed URL for uploading media (v2).
  public func upload() async throws -> MediaUploadUrls {
    return try await client.request(MediaEndpoint.upload)
  }
}
