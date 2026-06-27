using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateCustomReactionRequest(
    [property: JsonPropertyName("shortcode")] string Shortcode,
    [property: JsonPropertyName("displayName")] string DisplayName
);
