using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystSmartAlbum(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("description")] string Description,
    [property: JsonPropertyName("isAllowNsfw")] bool IsAllowNsfw,
    [property: JsonPropertyName("isAllowOthers")] bool IsAllowOthers,
    [property: JsonPropertyName("since")] DateTimeOffset? Since,
    [property: JsonPropertyName("until")] DateTimeOffset? Until,
    [property: JsonPropertyName("isPublic")] bool IsPublic,
    [property: JsonPropertyName("mode")] CatalystAlbumDisplayMode Mode,
    [property: JsonPropertyName("user")] EgeriaUser? User,
    [property: JsonPropertyName("type")] string? Type,
    [property: JsonPropertyName("statuses")] IReadOnlyList<CatalystStatus> Statuses,
    [property: JsonPropertyName("hashtags")] IReadOnlyList<string> Hashtags
);

public record CatalystSmartAlbums(
    [property: JsonPropertyName("albums")] IReadOnlyList<CatalystSmartAlbum> Albums
);
