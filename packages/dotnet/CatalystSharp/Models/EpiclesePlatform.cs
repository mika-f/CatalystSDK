using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record EpiclesePlatform(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("description")] string Description,
    [property: JsonPropertyName("url")] string? Url,
    [property: JsonPropertyName("startAt")] DateTimeOffset? StartAt
);

public record EpiclesePlatformWrapper(
    [property: JsonPropertyName("platform")] EpiclesePlatform Platform
);

public record EpiclesePlatformsWrapper(
    [property: JsonPropertyName("platforms")] IReadOnlyList<EpiclesePlatform> Platforms
);
