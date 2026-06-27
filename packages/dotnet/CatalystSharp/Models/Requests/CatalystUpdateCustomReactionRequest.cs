using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystUpdateCustomReactionRequest(
    [property: JsonPropertyName("displayName")] string? DisplayName = null,
    [property: JsonPropertyName("sortOrder")] int? SortOrder = null
);
