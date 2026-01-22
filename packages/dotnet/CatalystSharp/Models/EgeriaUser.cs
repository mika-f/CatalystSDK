using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record EgeriaUser(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("screenName")] string ScreenName,
    [property: JsonPropertyName("displayName")] string DisplayName,
    [property: JsonPropertyName("profile")] EgeriaUserProfile? Profile
);

public record EgeriaUserWrapper(
    [property: JsonPropertyName("user")] EgeriaUser User
);

public record EgeriaUsers(
    [property: JsonPropertyName("users")] IReadOnlyList<EgeriaUser> Users
);
