using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateFleetPlacement(
    [property: JsonPropertyName("posX")] double PosX,
    [property: JsonPropertyName("posY")] double PosY,
    [property: JsonPropertyName("scale")] double Scale,
    [property: JsonPropertyName("rotation")] double Rotation
);

public record CatalystCreateFleetMedia(
    [property: JsonPropertyName("url")] string Url,
    [property: JsonPropertyName("width")] int Width,
    [property: JsonPropertyName("height")] int Height,
    [property: JsonPropertyName("bytes")] long Bytes,
    [property: JsonPropertyName("placement")] CatalystCreateFleetPlacement Placement,
    [property: JsonPropertyName("alt")] string? Alt = null
);

public record CatalystCreateFleetText(
    [property: JsonPropertyName("backgroundColor")] string BackgroundColor,
    [property: JsonPropertyName("body")] string Body,
    // "default" | "bold" | "serif" | "handwriting"
    [property: JsonPropertyName("textStyle")] string TextStyle,
    // "left" | "center" | "right"
    [property: JsonPropertyName("textAlignment")] string TextAlignment,
    [property: JsonPropertyName("color")] string Color,
    [property: JsonPropertyName("posX")] double PosX,
    [property: JsonPropertyName("posY")] double PosY,
    [property: JsonPropertyName("scale")] double Scale,
    [property: JsonPropertyName("rotation")] double Rotation
);

public record CatalystCreateFleetSticker(
    [property: JsonPropertyName("posX")] double PosX,
    [property: JsonPropertyName("posY")] double PosY,
    [property: JsonPropertyName("scale")] double Scale,
    [property: JsonPropertyName("rotation")] double Rotation,
    [property: JsonPropertyName("emoji")] string Emoji
);

public record CatalystCreateFleetRequest(
    [property: JsonPropertyName("backgroundColor")] string BackgroundColor,
    [property: JsonPropertyName("texts")] IReadOnlyList<CatalystCreateFleetText> Texts,
    [property: JsonPropertyName("media")] CatalystCreateFleetMedia Media,
    [property: JsonPropertyName("stickers")] IReadOnlyList<CatalystCreateFleetSticker> Stickers
);
