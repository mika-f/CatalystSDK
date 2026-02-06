using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record Media(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("alt")] string Alt,
    [property: JsonPropertyName("url")] string Url,
    [property: JsonPropertyName("metadata")] MediaMetadata? Metadata,
    [property: JsonPropertyName("privacyMetadata")] bool? PrivacyMetadata
);
