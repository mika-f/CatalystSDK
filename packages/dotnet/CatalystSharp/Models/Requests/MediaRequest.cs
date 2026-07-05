using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record MediaDeleteRequest(
    [property: JsonPropertyName("url")] string Url
);
