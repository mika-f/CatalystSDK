using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record EpicleseAuthor(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("platformIdentifier")] string PlatformIdentifier,
    [property: JsonPropertyName("platform")] EpiclesePlatform? Platform,
    [property: JsonPropertyName("name")] string Name
);

public record EpicleseAuthorWrapper(
    [property: JsonPropertyName("author")] EpicleseAuthor Author
);

public record EpicleseAuthorsResult(
    [property: JsonPropertyName("items")] IReadOnlyList<EpicleseAuthor> Items,
    [property: JsonPropertyName("count")] CatalystCountInfo Count,
    [property: JsonPropertyName("page")] CatalystPageInfo Page
);
