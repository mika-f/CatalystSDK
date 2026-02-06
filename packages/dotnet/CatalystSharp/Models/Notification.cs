using System.Text.Json;
using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record Notification(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("isGrouped")] bool IsGrouped,
    [property: JsonPropertyName("belongsTo")] JsonElement BelongsTo,
    [property: JsonPropertyName("entities")] IReadOnlyList<NotificationGroup> Entities,
    [property: JsonPropertyName("hasMore")] bool HasMore,
    [property: JsonPropertyName("read")] bool Read
);

public record Notifications(
    [property: JsonPropertyName("notifications")] IReadOnlyList<Notification> Items
);
