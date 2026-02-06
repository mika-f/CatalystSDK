using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystReaction(
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("symbol")] string Symbol,
    [property: JsonPropertyName("url")] string Url,
    [property: JsonPropertyName("count")] int Count,
    [property: JsonPropertyName("hasSelfReaction")] bool? HasSelfReaction
);

public record CatalystReactions(
    [property: JsonPropertyName("reactions")] IReadOnlyDictionary<string, CatalystReaction> Reactions
);

