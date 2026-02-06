
using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record NotificationUnreadCount(
    [property: JsonPropertyName("unread")] int Unread
);
