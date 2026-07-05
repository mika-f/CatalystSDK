using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

// template: "photo-book" | "record-book"
// quality: "web" | "print"
// tocType: "per-post" | "page-only" | null
// status: "pending" | "processing" | "completed" | "failed"
public record CatalystAlbumBook(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("albumId")] string? AlbumId,
    [property: JsonPropertyName("smartAlbumId")] string? SmartAlbumId,
    [property: JsonPropertyName("template")] string Template,
    [property: JsonPropertyName("quality")] string Quality,
    [property: JsonPropertyName("coverImageUrl")] string? CoverImageUrl,
    [property: JsonPropertyName("subtitle")] string? Subtitle,
    [property: JsonPropertyName("customText")] string? CustomText,
    [property: JsonPropertyName("showBody")] bool ShowBody,
    [property: JsonPropertyName("showDate")] bool ShowDate,
    [property: JsonPropertyName("showUrl")] bool ShowUrl,
    [property: JsonPropertyName("tocType")] string? TocType,
    [property: JsonPropertyName("colophonText")] string? ColophonText,
    [property: JsonPropertyName("status")] string Status,
    [property: JsonPropertyName("errorMessage")] string? ErrorMessage,
    [property: JsonPropertyName("downloadUrl")] string? DownloadUrl,
    [property: JsonPropertyName("expiresAt")] DateTimeOffset? ExpiresAt,
    [property: JsonPropertyName("createdAt")] DateTimeOffset? CreatedAt,
    [property: JsonPropertyName("updatedAt")] DateTimeOffset? UpdatedAt
);
