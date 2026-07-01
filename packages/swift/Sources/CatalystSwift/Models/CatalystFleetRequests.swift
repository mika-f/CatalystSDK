// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystCreateFleetPlacement: Encodable, Sendable {
  public let posX: Double
  public let posY: Double
  public let scale: Double
  public let rotation: Double

  public init(posX: Double, posY: Double, scale: Double, rotation: Double) {
    self.posX = posX
    self.posY = posY
    self.scale = scale
    self.rotation = rotation
  }
}

public struct CatalystCreateFleetMedia: Encodable, Sendable {
  public let url: String
  public let width: Int
  public let height: Int
  public let bytes: Int
  public let placement: CatalystCreateFleetPlacement
  public let alt: String?

  public init(
    url: String, width: Int, height: Int, bytes: Int, placement: CatalystCreateFleetPlacement,
    alt: String? = nil
  ) {
    self.url = url
    self.width = width
    self.height = height
    self.bytes = bytes
    self.placement = placement
    self.alt = alt
  }
}

public struct CatalystCreateFleetText: Encodable, Sendable {
  public let backgroundColor: String
  public let body: String
  /// One of "default", "bold", "serif", "handwriting".
  public let textStyle: String
  /// One of "left", "center", "right".
  public let textAlignment: String
  public let color: String
  public let posX: Double
  public let posY: Double
  public let scale: Double
  public let rotation: Double

  public init(
    backgroundColor: String, body: String, textStyle: String, textAlignment: String,
    color: String, posX: Double, posY: Double, scale: Double, rotation: Double
  ) {
    self.backgroundColor = backgroundColor
    self.body = body
    self.textStyle = textStyle
    self.textAlignment = textAlignment
    self.color = color
    self.posX = posX
    self.posY = posY
    self.scale = scale
    self.rotation = rotation
  }
}

public struct CatalystCreateFleetSticker: Encodable, Sendable {
  public let posX: Double
  public let posY: Double
  public let scale: Double
  public let rotation: Double
  public let emoji: String

  public init(posX: Double, posY: Double, scale: Double, rotation: Double, emoji: String) {
    self.posX = posX
    self.posY = posY
    self.scale = scale
    self.rotation = rotation
    self.emoji = emoji
  }
}

public struct CatalystCreateFleetRequest: Encodable, Sendable {
  public let backgroundColor: String
  public let texts: [CatalystCreateFleetText]
  public let media: CatalystCreateFleetMedia
  public let stickers: [CatalystCreateFleetSticker]

  public init(
    backgroundColor: String, texts: [CatalystCreateFleetText], media: CatalystCreateFleetMedia,
    stickers: [CatalystCreateFleetSticker]
  ) {
    self.backgroundColor = backgroundColor
    self.texts = texts
    self.media = media
    self.stickers = stickers
  }
}
