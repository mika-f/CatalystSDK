using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystUpdateProfileTagsRequest(
    [property: JsonPropertyName("tags")] IReadOnlyList<string> Tags
);
