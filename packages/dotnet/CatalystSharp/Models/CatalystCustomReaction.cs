using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystCustomReaction(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("shortcode")] string Shortcode,
    [property: JsonPropertyName("displayName")] string DisplayName,
    [property: JsonPropertyName("imageUrl")] string ImageUrl,
    [property: JsonPropertyName("mimeType")] string MimeType,
    [property: JsonPropertyName("sortOrder")] int SortOrder,
    [property: JsonPropertyName("status")] string Status,
    [property: JsonPropertyName("createdAt")] string CreatedAt
);
