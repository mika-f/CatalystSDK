using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateStatusRequest(
    [property: JsonPropertyName("description")] string Description,
    [property: JsonPropertyName("isNsfw")] bool IsNsfw,
    [property: JsonPropertyName("isSpoiler")] bool IsSpoiler,
    [property: JsonPropertyName("isSubmitToContest")] bool IsSubmitToContest,
    [property: JsonPropertyName("isHidingLikeAndViewCount")] bool IsHidingLikeAndViewCount,
    [property: JsonPropertyName("isPrivateMetadata")] bool? IsPrivateMetadata,
    [property: JsonPropertyName("isAllowComments")] bool IsAllowComments,
    [property: JsonPropertyName("privacy")] CatalystStatusPrivacy? Privacy,
    [property: JsonPropertyName("contestId")] string? ContestId,
    [property: JsonPropertyName("media")] IReadOnlyList<CatalystMediaWithMetadata> Media
);

public record CatalystEditStatusRequest(
    [property: JsonPropertyName("description")] string Description
);
