using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record MediaDownloadRequest(
    [property: JsonPropertyName("url")] string Url
);

public record MediaDeleteRequest(
    [property: JsonPropertyName("url")] string Url
);
