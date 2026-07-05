using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

// reason: "nsfw" | "tos_violation" | "harassment" | "spam" | "other"
public record CatalystCreateReportRequest(
    [property: JsonPropertyName("reason")] string Reason,
    [property: JsonPropertyName("description")] string? Description = null
);
