using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystProfileTag(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("normalizedName")] string NormalizedName
);

public record CatalystProfileTagsWrapper(
    [property: JsonPropertyName("tags")] IReadOnlyList<CatalystProfileTag> Tags
);

public record CatalystProfileTagSuggestionsWrapper(
    [property: JsonPropertyName("tags")] IReadOnlyList<CatalystProfileTagSuggestion> Tags
);

public record CatalystProfileTagSuggestion(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("usageCount")] int UsageCount
);

public record CatalystProfileTagUser(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("screenName")] string ScreenName,
    [property: JsonPropertyName("displayName")] string DisplayName,
    [property: JsonPropertyName("profile")] EgeriaUserProfile? Profile,
    [property: JsonPropertyName("profileEmoji")] EgeriaUserProfileEmoji? ProfileEmoji,
    [property: JsonPropertyName("matchedTags")] IReadOnlyList<string> MatchedTags
);

public record CatalystProfileTagUsersResult(
    [property: JsonPropertyName("tag")] CatalystProfileTagSummary Tag,
    [property: JsonPropertyName("users")] IReadOnlyList<CatalystProfileTagUser> Users,
    [property: JsonPropertyName("nextCursor")] string? NextCursor
);

public record CatalystProfileTagSummary(
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("usageCount")] int UsageCount
);
