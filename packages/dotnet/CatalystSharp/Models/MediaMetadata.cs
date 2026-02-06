using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record MediaMetadata(
    [property: JsonPropertyName("width")] int? Width,
    [property: JsonPropertyName("height")] int? Height,
    [property: JsonPropertyName("isSensitive")] bool IsSensitive,
    [property: JsonPropertyName("isSpoiler")] bool IsSpoiler
);
