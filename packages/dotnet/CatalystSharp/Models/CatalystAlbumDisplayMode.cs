using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

[JsonConverter(typeof(JsonStringEnumConverter<CatalystAlbumDisplayMode>))]
public enum CatalystAlbumDisplayMode
{
    [JsonPropertyName("timeline")]
    Timeline,

    [JsonPropertyName("grid")]
    Grid,

    [JsonPropertyName("gallery")]
    Gallery
}
