using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystRelationships(
    [property: JsonPropertyName("isMyself")] bool IsMyself,
    [property: JsonPropertyName("isFollowing")] bool IsFollowing,
    [property: JsonPropertyName("isFollowed")] bool IsFollowed
);
