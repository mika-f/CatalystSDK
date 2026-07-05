using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

[JsonConverter(typeof(JsonStringEnumConverter<CatalystContestState>))]
public enum CatalystContestState
{
    [JsonPropertyName("draft")] Draft,
    [JsonPropertyName("published")] Published,
    [JsonPropertyName("opening")] Opening,
    [JsonPropertyName("closing")] Closing,
    [JsonPropertyName("voting")] Voting,
    [JsonPropertyName("electing")] Electing,
    [JsonPropertyName("closed")] Closed
}

public record CatalystContestVoting(
    [property: JsonPropertyName("since")] string Since,
    [property: JsonPropertyName("until")] string Until,
    [property: JsonPropertyName("maxVotes")] int MaxVotes,
    [property: JsonPropertyName("isEnable")] bool IsEnable
);

public record CatalystContestRank(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("name")] string Name,
    [property: JsonPropertyName("description")] string? Description,
    [property: JsonPropertyName("count")] int Count,
    [property: JsonPropertyName("prize")] string Prize,
    [property: JsonPropertyName("winners")] IReadOnlyList<EgeriaUser> Winners
);

public record CatalystContest(
    [property: JsonPropertyName("slug")] string Slug,
    [property: JsonPropertyName("draft")] bool Draft,
    [property: JsonPropertyName("state")] CatalystContestState State,
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("description")] string Description,
    [property: JsonPropertyName("theme")] string Theme,
    [property: JsonPropertyName("terms")] string Terms,
    [property: JsonPropertyName("headerUrl")] string HeaderUrl,
    [property: JsonPropertyName("bannerUrl")] string BannerUrl,
    [property: JsonPropertyName("organizer")] EgeriaUser Organizer,
    [property: JsonPropertyName("winnersOpenAt")] string WinnersOpenAt,
    [property: JsonPropertyName("winnersMessageSendAt")] string WinnersMessageSendAt,
    [property: JsonPropertyName("publishedAt")] string PublishedAt,
    [property: JsonPropertyName("since")] string Since,
    [property: JsonPropertyName("until")] string Until,
    [property: JsonPropertyName("allowSensitive")] bool AllowSensitive,
    [property: JsonPropertyName("maxMediaPerEntry")] int? MaxMediaPerEntry,
    [property: JsonPropertyName("voting")] CatalystContestVoting Voting,
    [property: JsonPropertyName("ranks")] IReadOnlyList<CatalystContestRank> Ranks
);

public record CatalystUserVoteRights(
    [property: JsonPropertyName("remaining")] int Remaining,
    [property: JsonPropertyName("statuses")] IReadOnlyList<string> Statuses
);

public record CatalystContestWrapper(
    [property: JsonPropertyName("contest")] CatalystContest Contest
);

public record CatalystContestsWrapper(
    [property: JsonPropertyName("contests")] IReadOnlyList<CatalystContest> Contests
);
