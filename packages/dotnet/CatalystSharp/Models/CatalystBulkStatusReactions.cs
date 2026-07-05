using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystBulkStatusReactions(
    [property: JsonPropertyName("reactions")] IReadOnlyDictionary<string, IReadOnlyDictionary<string, CatalystReaction>> Reactions
);
