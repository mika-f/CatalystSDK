using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystCustomReaction(
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("symbol")] string Symbol,
    [property: JsonPropertyName("url")] string Url
);