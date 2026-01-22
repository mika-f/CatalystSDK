using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystMediaWithMetadata(
    [property: JsonPropertyName("url")] string Url,
    [property: JsonPropertyName("alt")] string Alt,
    [property: JsonPropertyName("width")] int Width,
    [property: JsonPropertyName("height")] int Height,
    [property: JsonPropertyName("bytes")] int Bytes
);
