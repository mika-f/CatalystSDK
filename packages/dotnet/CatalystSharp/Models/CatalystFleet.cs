using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystFleetPlacement(
    [property: JsonPropertyName("posX")] double PosX,
    [property: JsonPropertyName("posY")] double PosY,
    [property: JsonPropertyName("scale")] double Scale,
    [property: JsonPropertyName("rotation")] double Rotation
);

public record CatalystFleetText(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("body")] string Body,
    [property: JsonPropertyName("textStyle")] string TextStyle,
    [property: JsonPropertyName("textAlignment")] string TextAlignment,
    [property: JsonPropertyName("color")] string Color,
    [property: JsonPropertyName("backgroundColor")] string? BackgroundColor,
    [property: JsonPropertyName("posX")] double PosX,
    [property: JsonPropertyName("posY")] double PosY,
    [property: JsonPropertyName("scale")] double Scale,
    [property: JsonPropertyName("rotation")] double Rotation
);

public record CatalystFleetSticker(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("emoji")] string Emoji,
    [property: JsonPropertyName("posX")] double PosX,
    [property: JsonPropertyName("posY")] double PosY,
    [property: JsonPropertyName("scale")] double Scale,
    [property: JsonPropertyName("rotation")] double Rotation
);

public record CatalystFleetMedia(
    [property: JsonPropertyName("url")] string Url,
    [property: JsonPropertyName("alt")] string Alt,
    [property: JsonPropertyName("width")] int? Width,
    [property: JsonPropertyName("height")] int? Height,
    [property: JsonPropertyName("placement")] CatalystFleetPlacement? Placement
);

public record CatalystFleet(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("backgroundColor")] string BackgroundColor,
    [property: JsonPropertyName("renderedImageUrl")] string? RenderedImageUrl,
    [property: JsonPropertyName("user")] EgeriaUser User,
    [property: JsonPropertyName("texts")] IReadOnlyList<CatalystFleetText> Texts,
    [property: JsonPropertyName("media")] CatalystFleetMedia? Media,
    [property: JsonPropertyName("stickers")] IReadOnlyList<CatalystFleetSticker> Stickers,
    [property: JsonPropertyName("reactions")] IReadOnlyDictionary<string, CatalystReaction> Reactions,
    [property: JsonPropertyName("viewCount")] int ViewCount,
    [property: JsonPropertyName("createdAt")] DateTimeOffset CreatedAt,
    [property: JsonPropertyName("expiresAt")] DateTimeOffset ExpiresAt
);

public record CatalystFleetViewer(
    [property: JsonPropertyName("user")] EgeriaUser User,
    [property: JsonPropertyName("viewedAt")] DateTimeOffset ViewedAt
);

public record CatalystFleetRing(
    [property: JsonPropertyName("user")] EgeriaUser User,
    [property: JsonPropertyName("hasUnread")] bool HasUnread,
    [property: JsonPropertyName("fleetCount")] int FleetCount
);
