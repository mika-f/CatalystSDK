using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record EpicleseWorld(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("platformIdentifier")] string PlatformIdentifier,
    [property: JsonPropertyName("platform")] EpiclesePlatform? Platform,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("author")] EpicleseAuthor? Author
);

public record EpicleseWorldWrapper(
    [property: JsonPropertyName("world")] EpicleseWorld? World
);

public record EpicleseWorldsResult(
    [property: JsonPropertyName("items")] IReadOnlyList<EpicleseWorld> Items
);
