using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record EgeriaUserProfile(
    [property: JsonPropertyName("iconUrl")] string IconUrl,
    [property: JsonPropertyName("bannerUrl")] string BannerUrl,
    [property: JsonPropertyName("bio")] string Bio,
    [property: JsonPropertyName("website")] string Website,
    [property: JsonPropertyName("additionalWebsites")] IReadOnlyList<string> AdditionalWebsites
);
