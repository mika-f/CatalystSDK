using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record NotificationAdditionalContext(
    [property: JsonPropertyName("type")] string Type,
    [property: JsonPropertyName("url")] string Url,
    [property: JsonPropertyName("format")] string Format
);

public record NotificationGroup(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("body")] string Body,
    [property: JsonPropertyName("occurredBy")]
    EgeriaUser OccurredBy,
    [property: JsonPropertyName("isRead")] bool IsRead,
    [property: JsonPropertyName("createdAt")] string CreatedAt,
    [property: JsonPropertyName("additionalContexts")]
    NotificationAdditionalContext? AdditionalContexts = null
);
