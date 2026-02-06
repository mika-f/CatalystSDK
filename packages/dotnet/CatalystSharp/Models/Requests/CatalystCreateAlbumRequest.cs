using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateAlbumRequest(
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("description")] string Description,
    [property: JsonPropertyName("isPublic")] bool IsPublic,
    [property: JsonPropertyName("mode")] CatalystAlbumDisplayMode Mode
);
