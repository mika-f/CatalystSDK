using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

// GET /catalyst/v1/reactions が返す標準絵文字リアクション定義
public record CatalystCustomReaction(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("symbol")] string Symbol,
    [property: JsonPropertyName("url")] string Url
);

// GET /catalyst/v1/custom-reactions の items に含まれるユーザー独自リアクション
public record CatalystUserCustomReaction(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("shortcode")] string Shortcode,
    [property: JsonPropertyName("displayName")] string DisplayName,
    [property: JsonPropertyName("imageUrl")] string ImageUrl,
    [property: JsonPropertyName("mimeType")] string MimeType,
    [property: JsonPropertyName("sortOrder")] int SortOrder,
    [property: JsonPropertyName("status")] string Status,
    [property: JsonPropertyName("createdAt")] string CreatedAt
);
