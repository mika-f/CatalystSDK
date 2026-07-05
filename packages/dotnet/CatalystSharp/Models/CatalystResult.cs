using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystResult(
    [property: JsonPropertyName("result")] bool Result
);

public record CatalystReactionValue(
    [property: JsonPropertyName("value")] int Value
);

public record CatalystMessage(
    [property: JsonPropertyName("message")] string Message
);
