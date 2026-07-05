using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystFeatureFlags(
    [property: JsonPropertyName("flags")] IReadOnlyList<string> Flags
);
