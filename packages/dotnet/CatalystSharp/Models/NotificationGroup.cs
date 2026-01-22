using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record NotificationGroup(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("body")] string Body,
    [property: JsonPropertyName("occurredBy")]
    EgeriaUser OccurredBy,
    [property: JsonPropertyName("isRead")] bool IsRead
);