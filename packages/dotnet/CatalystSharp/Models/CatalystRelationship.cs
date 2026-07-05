using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystRelationships(
    [property: JsonPropertyName("isMyself")] bool IsMyself,
    [property: JsonPropertyName("isFollowing")] bool IsFollowing,
    [property: JsonPropertyName("isFollowed")] bool IsFollowed,
    [property: JsonPropertyName("isBlocking")] bool IsBlocking
);

public record CatalystRelationshipsCount(
    [property: JsonPropertyName("followings")] int? Followings,
    [property: JsonPropertyName("followers")] int? Followers
);

public record CatalystFollowingOrFollowersList(
    [property: JsonPropertyName("items")] IReadOnlyList<EgeriaUser> Items,
    [property: JsonPropertyName("count")] CatalystCountInfo Count,
    [property: JsonPropertyName("page")] CatalystPageInfo Page
);
