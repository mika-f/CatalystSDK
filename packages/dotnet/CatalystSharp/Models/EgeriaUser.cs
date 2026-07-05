using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record EgeriaUser(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("screenName")] string ScreenName,
    [property: JsonPropertyName("displayName")] string DisplayName,
    [property: JsonPropertyName("profile")] EgeriaUserProfile? Profile,
    [property: JsonPropertyName("profileEmoji")] EgeriaUserProfileEmoji? ProfileEmoji = null
);

// "standard" 型は value/imageUrl、"custom" 型は id/shortcode/displayName/imageUrl/width/height を持つ
public record EgeriaUserProfileEmoji(
    [property: JsonPropertyName("type")] string Type,
    [property: JsonPropertyName("value")] string? Value = null,
    [property: JsonPropertyName("id")] string? Id = null,
    [property: JsonPropertyName("shortcode")] string? Shortcode = null,
    [property: JsonPropertyName("displayName")] string? DisplayName = null,
    [property: JsonPropertyName("imageUrl")] string? ImageUrl = null,
    [property: JsonPropertyName("width")] double? Width = null,
    [property: JsonPropertyName("height")] double? Height = null
);

public record EgeriaUserWrapper(
    [property: JsonPropertyName("user")] EgeriaUser User
);

public record EgeriaUsers(
    [property: JsonPropertyName("users")] IReadOnlyList<EgeriaUser> Users
);
