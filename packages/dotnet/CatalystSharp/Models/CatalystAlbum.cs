using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystAlbum(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("description")] string Description,
    [property: JsonPropertyName("isPublic")] bool IsPublic,
    [property: JsonPropertyName("mode")] CatalystAlbumDisplayMode Mode,
    [property: JsonPropertyName("user")] EgeriaUser User,
    [property: JsonPropertyName("statuses")] IReadOnlyList<CatalystStatus> Statuses
);
