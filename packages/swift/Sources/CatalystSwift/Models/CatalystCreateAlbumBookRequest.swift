// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// Request body shared by `POST /catalyst/v1/album/by/id/{id}/book` and
/// `POST /catalyst/v1/smart-album/by/id/{id}/book`.
///
/// `template` is one of "photo-book" | "record-book".
/// `quality` is one of "web" | "print".
/// `tocType` is one of "per-post" | "page-only" | nil.
public struct CatalystCreateAlbumBookRequest: Encodable, Sendable {
  public let template: String
  public let quality: String
  public let coverImageUrl: String?
  public let subtitle: String?
  public let customText: String?
  public let showBody: Bool?
  public let showDate: Bool?
  public let showUrl: Bool?
  public let showQrCode: Bool?
  public let tocType: String?
  public let colophonText: String?

  public init(
    template: String,
    quality: String,
    coverImageUrl: String? = nil,
    subtitle: String? = nil,
    customText: String? = nil,
    showBody: Bool? = nil,
    showDate: Bool? = nil,
    showUrl: Bool? = nil,
    showQrCode: Bool? = nil,
    tocType: String? = nil,
    colophonText: String? = nil
  ) {
    self.template = template
    self.quality = quality
    self.coverImageUrl = coverImageUrl
    self.subtitle = subtitle
    self.customText = customText
    self.showBody = showBody
    self.showDate = showDate
    self.showUrl = showUrl
    self.showQrCode = showQrCode
    self.tocType = tocType
    self.colophonText = colophonText
  }
}
