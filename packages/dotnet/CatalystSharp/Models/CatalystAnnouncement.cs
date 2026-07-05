using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystAnnouncement(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("body")] string Body,
    [property: JsonPropertyName("category")] string Category,
    [property: JsonPropertyName("since")] DateTimeOffset Since,
    [property: JsonPropertyName("until")] DateTimeOffset Until,
    [property: JsonPropertyName("url")] string? Url
);

public record CatalystAnnouncementsWrapper(
    [property: JsonPropertyName("announcements")] IReadOnlyList<CatalystAnnouncement> Announcements
);
