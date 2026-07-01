using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystCreateContestRequest(
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("description")] string Description,
    [property: JsonPropertyName("theme")] string Theme
);

public record CatalystContestApplicationRequest(
    [property: JsonPropertyName("since")] string? Since,
    [property: JsonPropertyName("until")] string? Until,
    [property: JsonPropertyName("allowSensitive")] bool AllowSensitive,
    [property: JsonPropertyName("maxMediaPerEntry")] int? MaxMediaPerEntry
);

public record CatalystContestVotingRequest(
    [property: JsonPropertyName("since")] string? Since,
    [property: JsonPropertyName("until")] string? Until,
    [property: JsonPropertyName("maxVotes")] int? MaxVotes,
    [property: JsonPropertyName("isEnableVoting")] bool? IsEnableVoting
);

public record CatalystContestWinnersRequest(
    [property: JsonPropertyName("since")] string? Since,
    [property: JsonPropertyName("until")] string? Until
);

public record CatalystEditContestRankRequest(
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("description")] string? Description,
    [property: JsonPropertyName("count")] int Count,
    [property: JsonPropertyName("prize")] string Prize
);

public record CatalystEditContestRequest(
    [property: JsonPropertyName("title")] string? Title = null,
    [property: JsonPropertyName("description")] string? Description = null,
    [property: JsonPropertyName("theme")] string? Theme = null,
    [property: JsonPropertyName("terms")] string? Terms = null,
    [property: JsonPropertyName("headerUrl")] string? HeaderUrl = null,
    [property: JsonPropertyName("bannerUrl")] string? BannerUrl = null,
    [property: JsonPropertyName("winnersOpenAt")] string? WinnersOpenAt = null,
    [property: JsonPropertyName("winnersMessageSendAt")] string? WinnersMessageSendAt = null,
    [property: JsonPropertyName("publishedAt")] string? PublishedAt = null,
    [property: JsonPropertyName("application")] CatalystContestApplicationRequest? Application = null,
    [property: JsonPropertyName("voting")] CatalystContestVotingRequest? Voting = null,
    [property: JsonPropertyName("winners")] CatalystContestWinnersRequest? Winners = null,
    [property: JsonPropertyName("ranks")] IReadOnlyList<CatalystEditContestRankRequest>? Ranks = null
);

public record CatalystSetContestAwardRequest(
    [property: JsonPropertyName("status")] string Status,
    [property: JsonPropertyName("message")] string? Message = null,
    [property: JsonPropertyName("commentary")] string? Commentary = null
);

public record CatalystUnsetContestAwardRequest(
    [property: JsonPropertyName("status")] string Status,
    [property: JsonPropertyName("message")] string? Message = null,
    [property: JsonPropertyName("commentary")] string? Commentary = null
);

public record CatalystContestAddCollaboratorRequest(
    [property: JsonPropertyName("userId")] string UserId,
    // "collaborator" または "contributor" のみ許可される
    [property: JsonPropertyName("role")] string Role
);

public record CatalystContestRemoveCollaboratorRequest(
    [property: JsonPropertyName("userId")] string UserId
);
