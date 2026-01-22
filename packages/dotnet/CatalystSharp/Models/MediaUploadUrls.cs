using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record MediaUploadUrls(
    [property: JsonPropertyName("url")] string Url,
    [property: JsonPropertyName("signedUrl")]
    string SignedUrl
);
