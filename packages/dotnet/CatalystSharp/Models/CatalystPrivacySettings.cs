using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

// followingListVisibility, followerListVisibility: "public" | "private"
// GET/PATCH /catalyst/v1/privacy/settings のリクエストとレスポンスは同一の形状
public record CatalystPrivacySettings(
    [property: JsonPropertyName("followingListVisibility")] string FollowingListVisibility,
    [property: JsonPropertyName("followerListVisibility")] string FollowerListVisibility
);
