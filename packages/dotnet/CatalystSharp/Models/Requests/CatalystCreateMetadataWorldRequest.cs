using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateMetadataWorldRequest(
    [property: JsonPropertyName("platformIdentifier")] string PlatformIdentifier,
    [property: JsonPropertyName("platform")] string Platform,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("author")] CatalystCreateMetadataAuthorRequest? Author,
    [property: JsonPropertyName("id")] string? Id = null
);
