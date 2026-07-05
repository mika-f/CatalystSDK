using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record EpicleseStatusMetadataReference(
    [property: JsonPropertyName("x")] double X,
    [property: JsonPropertyName("y")] double Y,
    [property: JsonPropertyName("reference")] string? Reference,
    [property: JsonPropertyName("type")] string Type,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("description")] string? Description,
    [property: JsonPropertyName("externalUrl")] string? ExternalUrl,
    [property: JsonPropertyName("author")] EpicleseAuthor? Author
);

// GET/POST /epiclese/v1/tag/by/status/{id} は、tag id をキーとした Dictionary を返す
public record EpicleseStatusMetadataTag(
    [property: JsonPropertyName("platform")] string? Platform,
    [property: JsonPropertyName("world")] EpicleseWorld? World,
    [property: JsonPropertyName("users")] IReadOnlyList<EgeriaUser> Users,
    [property: JsonPropertyName("reference")] IReadOnlyList<EpicleseStatusMetadataReference> Reference,
    [property: JsonPropertyName("additionalData")] IReadOnlyDictionary<string, string>? AdditionalData = null
);
