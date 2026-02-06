using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystInsertToAlbumRequest(
    [property: JsonPropertyName("insert")] string Insert
);

public record CatalystRemoveFromAlbumRequest(
    [property: JsonPropertyName("remove")] string Remove
);
