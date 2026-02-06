using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record Identity(
    [property: JsonPropertyName("id")] string Id
);
