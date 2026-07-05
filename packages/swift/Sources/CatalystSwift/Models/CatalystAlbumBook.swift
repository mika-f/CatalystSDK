// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

/// A generated photo/record book for an album or smart album.
///
/// `template` is one of "photo-book" | "record-book".
/// `quality` is one of "web" | "print".
/// `tocType` is one of "per-post" | "page-only" | nil.
/// `status` is one of "pending" | "processing" | "completed" | "failed".
public struct CatalystAlbumBook: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let albumId: String?
  public let smartAlbumId: String?
  public let template: String
  public let quality: String
  public let coverImageUrl: String?
  public let subtitle: String?
  public let customText: String?
  public let showBody: Bool
  public let showDate: Bool
  public let showUrl: Bool
  public let tocType: String?
  public let colophonText: String?
  public let status: String
  public let errorMessage: String?
  public let downloadUrl: String?
  public let expiresAt: Date?
  public let createdAt: Date?
  public let updatedAt: Date?
}
