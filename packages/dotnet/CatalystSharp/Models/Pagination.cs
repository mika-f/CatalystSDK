using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystCountInfo(
    [property: JsonPropertyName("total")] int Total,
    [property: JsonPropertyName("offset")] int Offset
);

public record CatalystPageInfo(
    [property: JsonPropertyName("min")] int Min,
    [property: JsonPropertyName("max")] int Max,
    [property: JsonPropertyName("current")] int Current,
    [property: JsonPropertyName("next")] int? Next,
    [property: JsonPropertyName("prev")] int? Prev
);
