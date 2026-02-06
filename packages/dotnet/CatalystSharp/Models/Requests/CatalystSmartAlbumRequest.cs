using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateSmartAlbumRequest(
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("description")] string Description,
    [property: JsonPropertyName("hashtags")] IReadOnlyList<string> Hashtags,
    [property: JsonPropertyName("since")] DateTimeOffset? Since,
    [property: JsonPropertyName("until")] DateTimeOffset? Until,
    [property: JsonPropertyName("isAllowNsfw")] bool? IsAllowNsfw,
    [property: JsonPropertyName("isAllowOthers")] bool? IsAllowOthers,
    [property: JsonPropertyName("isPublic")] bool IsPublic,
    [property: JsonPropertyName("mode")] CatalystAlbumDisplayMode? Mode
);

public record CatalystEditSmartAlbumRequest(
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("description")] string Description,
    [property: JsonPropertyName("hashtags")] IReadOnlyList<string> Hashtags,
    [property: JsonPropertyName("since")] DateTimeOffset? Since,
    [property: JsonPropertyName("until")] DateTimeOffset? Until,
    [property: JsonPropertyName("isAllowNsfw")] bool? IsAllowNsfw,
    [property: JsonPropertyName("isAllowOthers")] bool? IsAllowOthers,
    [property: JsonPropertyName("isPublic")] bool IsPublic,
    [property: JsonPropertyName("mode")] CatalystAlbumDisplayMode? Mode
);
