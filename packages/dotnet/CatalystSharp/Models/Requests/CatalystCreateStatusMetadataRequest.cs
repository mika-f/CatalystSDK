using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateStatusMetadataReference(
    [property: JsonPropertyName("x")] int X,
    [property: JsonPropertyName("y")] int Y,
    [property: JsonPropertyName("type")] string Type,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("reference")] string? Reference = null,
    [property: JsonPropertyName("description")] string? Description = null,
    [property: JsonPropertyName("externalUrl")] string? ExternalUrl = null,
    [property: JsonPropertyName("author")] CatalystCreateMetadataAuthorRequest? Author = null
);

public record CatalystCreateStatusMetadataUser(
    [property: JsonPropertyName("id")] string Id
);

// POST /epiclese/v1/tag/by/status/{id} のボディは、タグ情報の配列
public record CatalystCreateStatusMetadataItem(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("reference")] IReadOnlyList<CatalystCreateStatusMetadataReference> Reference,
    [property: JsonPropertyName("platform")] string? Platform = null,
    [property: JsonPropertyName("world")] CatalystCreateMetadataWorldRequest? World = null,
    [property: JsonPropertyName("users")] IReadOnlyList<CatalystCreateStatusMetadataUser>? Users = null,
    [property: JsonPropertyName("privacyMetadata")] bool? PrivacyMetadata = null
);
