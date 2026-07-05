using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

// PUT /catalyst/v1/album/by/id/{id} は insert/remove のどちらか一方を指定する
public record CatalystInsertOrRemoveAlbumItemRequest(
    [property: JsonPropertyName("insert")] string? Insert = null,
    [property: JsonPropertyName("remove")] string? Remove = null
);
