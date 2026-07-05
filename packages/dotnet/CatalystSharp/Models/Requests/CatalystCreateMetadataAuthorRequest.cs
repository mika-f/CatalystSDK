using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateMetadataAuthorRequest(
    [property: JsonPropertyName("platformIdentifier")] string PlatformIdentifier,
    [property: JsonPropertyName("platform")] string Platform,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("id")] string? Id = null
);
