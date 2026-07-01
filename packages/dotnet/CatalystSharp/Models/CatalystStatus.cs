using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystStatusContest(
    [property: JsonPropertyName("slug")] string Slug,
    [property: JsonPropertyName("title")] string Title,
    [property: JsonPropertyName("headerUrl")] string HeaderUrl,
    [property: JsonPropertyName("bannerUrl")] string? BannerUrl
);

public record CatalystStatus(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("body")] string Body,
    [property: JsonPropertyName("user")] EgeriaUser? User,
    [property: JsonPropertyName("medias")] IReadOnlyList<Media> Medias,
    [property: JsonPropertyName("contest")] CatalystStatusContest? Contest,
    [property: JsonPropertyName("createdAt")] DateTimeOffset CreatedAt,
    // 常に空配列。リアクションは GetReactionsAsync() を利用すること
    [property: JsonPropertyName("reactions")] IReadOnlyList<object>? Reactions = null
);

public record CatalystStatusVisitor(
    [property: JsonPropertyName("favorite")] bool Favorite,
    [property: JsonPropertyName("reactions")] IReadOnlyList<string>? Reactions
);

public record CatalystStatusV1_1(
    [property: JsonPropertyName("id")] string Id,
    [property: JsonPropertyName("body")] string Body,
    [property: JsonPropertyName("user")] EgeriaUser? User,
    [property: JsonPropertyName("medias")] IReadOnlyList<Media> Medias,
    [property: JsonPropertyName("contest")] CatalystStatusContest? Contest,
    [property: JsonPropertyName("reactions")] IReadOnlyDictionary<string, CatalystReaction> Reactions,
    [property: JsonPropertyName("createdAt")] DateTimeOffset CreatedAt,
    [property: JsonPropertyName("updatedAt")] DateTimeOffset UpdatedAt,
    [property: JsonPropertyName("visitor")] CatalystStatusVisitor? Visitor,
    [property: JsonPropertyName("privacy")] CatalystStatusPrivacy Privacy
);

public record CatalystStatusWrapper(
    [property: JsonPropertyName("status")] CatalystStatusV1_1 Status
);

public record CatalystStatuses(
    [property: JsonPropertyName("statuses")] IReadOnlyList<CatalystStatus> Statuses
);
