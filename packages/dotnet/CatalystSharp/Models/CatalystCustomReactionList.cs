using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystCustomReactionList(
    [property: JsonPropertyName("plan")] string Plan,
    [property: JsonPropertyName("limit")] int Limit,
    [property: JsonPropertyName("used")] int Used,
    [property: JsonPropertyName("items")] IReadOnlyList<CatalystCustomReaction> Items
);
