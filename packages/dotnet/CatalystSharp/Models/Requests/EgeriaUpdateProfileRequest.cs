using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record EgeriaUpdateProfileRequest(
    [property: JsonPropertyName("screenName")] string? ScreenName = null,
    [property: JsonPropertyName("displayName")] string? DisplayName = null,
    [property: JsonPropertyName("profile")] EgeriaUserProfile? Profile = null
);
