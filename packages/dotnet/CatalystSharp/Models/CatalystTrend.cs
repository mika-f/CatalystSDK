using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

// movement: "up" | "down" | "same" | "new"
public record CatalystRichTrendingItem(
    [property: JsonPropertyName("tag")] string Tag,
    [property: JsonPropertyName("rank")] int Rank,
    [property: JsonPropertyName("previousRank")] int? PreviousRank,
    [property: JsonPropertyName("movement")] string Movement
);
