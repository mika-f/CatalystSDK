using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateAlbumRequest(
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("description")] string? Description = null,
    [property: JsonPropertyName("isPublic")] bool? IsPublic = null,
    [property: JsonPropertyName("mode")] CatalystAlbumDisplayMode? Mode = null
);
