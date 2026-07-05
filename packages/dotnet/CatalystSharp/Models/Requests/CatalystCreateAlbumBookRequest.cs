using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

// template: "photo-book" | "record-book"
// quality: "web" | "print"
// tocType: "per-post" | "page-only" | null
public record CatalystCreateAlbumBookRequest(
    [property: JsonPropertyName("template")] string Template,
    [property: JsonPropertyName("quality")] string Quality,
    [property: JsonPropertyName("coverImageUrl")] string? CoverImageUrl = null,
    [property: JsonPropertyName("subtitle")] string? Subtitle = null,
    [property: JsonPropertyName("customText")] string? CustomText = null,
    [property: JsonPropertyName("showBody")] bool? ShowBody = null,
    [property: JsonPropertyName("showDate")] bool? ShowDate = null,
    [property: JsonPropertyName("showUrl")] bool? ShowUrl = null,
    [property: JsonPropertyName("showQrCode")] bool? ShowQrCode = null,
    [property: JsonPropertyName("tocType")] string? TocType = null,
    [property: JsonPropertyName("colophonText")] string? ColophonText = null
);
