using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystStatus(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("body")] string Body,
    [property: JsonPropertyName("user")] EgeriaUser? User,
    [property: JsonPropertyName("medias")] IReadOnlyList<Media> Medias,
    [property: JsonPropertyName("createdAt")] DateTimeOffset CreatedAt,
    [property: JsonPropertyName("updatedAt")] DateTimeOffset? UpdatedAt
);

public record CatalystStatusWrapper(
    [property: JsonPropertyName("status")] CatalystStatus Status
);

public record CatalystStatuses(
    [property: JsonPropertyName("statuses")] IReadOnlyList<CatalystStatus> Statuses
);
