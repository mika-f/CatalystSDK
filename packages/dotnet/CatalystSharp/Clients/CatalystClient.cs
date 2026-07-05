using CatalystSharp.Http;
using CatalystSharp.Models;
using CatalystSharp.Models.Requests;

namespace CatalystSharp.Clients;

public class CatalystClient
{
    private readonly ICatalystHttpClient _httpClient;

    internal CatalystClient(ICatalystHttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    #region Album

    public async Task<Identity> CreateAlbumAsync(CatalystCreateAlbumRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<Identity>("/catalyst/v1/album", request, cancellationToken);
    }

    public async Task<CatalystAlbum> GetAlbumAsync(string id, int? limit = null, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystAlbum>($"/catalyst/v1/album/by/id/{id}", new Dictionary<string, string?>
        {
            ["limit"] = limit?.ToString(),
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task<CatalystResult> InsertToAlbumAsync(string id, string statusId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PutAsync<CatalystResult>($"/catalyst/v1/album/by/id/{id}", new CatalystInsertOrRemoveAlbumItemRequest(Insert: statusId), cancellationToken);
    }

    public async Task<CatalystResult> RemoveFromAlbumAsync(string id, string statusId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PutAsync<CatalystResult>($"/catalyst/v1/album/by/id/{id}", new CatalystInsertOrRemoveAlbumItemRequest(Remove: statusId), cancellationToken);
    }

    public async Task<CatalystResult> EditAlbumAsync(string id, CatalystEditAlbumRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PatchAsync<CatalystResult>($"/catalyst/v1/album/by/id/{id}", request, cancellationToken);
    }

    public async Task<CatalystResult> DeleteAlbumAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystResult>($"/catalyst/v1/album/by/id/{id}", cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystAlbumBook>> GetAlbumBooksAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystAlbumBook>>($"/catalyst/v1/album/by/id/{id}/book", cancellationToken);
    }

    public async Task<CatalystAlbumBook> CreateAlbumBookAsync(string id, CatalystCreateAlbumBookRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystAlbumBook>($"/catalyst/v1/album/by/id/{id}/book", request, cancellationToken);
    }

    public async Task<CatalystAlbumBook> GetAlbumBookAsync(string id, string bookId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystAlbumBook>($"/catalyst/v1/album/by/id/{id}/book/{bookId}", cancellationToken);
    }

    public async Task<CatalystAlbumBook> RegenerateAlbumBookAsync(string id, string bookId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystAlbumBook>($"/catalyst/v1/album/by/id/{id}/book/{bookId}/regenerate", null, cancellationToken);
    }

    public async Task<CatalystSmartAlbums> GetAlbumsByMeAsync(bool includeSmartAlbums = false, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbums>("/catalyst/v1/album/by/me", new Dictionary<string, string?>
        {
            ["include_smart_albums"] = includeSmartAlbums ? "true" : "false"
        }, cancellationToken);
    }

    public async Task<CatalystSmartAlbums> ListAlbumsAsync(string username, bool includeSmartAlbum = true, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbums>($"/catalyst/v1/album/by/user/{username}", new Dictionary<string, string?>
        {
            ["include_smart_album"] = includeSmartAlbum ? "true" : "false"
        }, cancellationToken);
    }

    public async Task<CatalystSmartAlbums> SearchAlbumsAsync(string? query = null, bool includeSmartAlbum = true, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbums>("/catalyst/v1/album/search", new Dictionary<string, string?>
        {
            ["q"] = query,
            ["include_smart_album"] = includeSmartAlbum ? "true" : "false",
            ["until"] = until
        }, cancellationToken);
    }

    #endregion

    #region Announcements

    public async Task<IReadOnlyList<CatalystAnnouncement>> GetAnnouncementsAsync(CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystAnnouncementsWrapper>("/catalyst/v1/announcements", cancellationToken);
        return response.Announcements;
    }

    #endregion

    #region Blocks

    public async Task<CatalystResult> BlockAsync(CatalystRelationshipRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystResult>("/catalyst/v1/blocks", request, cancellationToken);
    }

    public async Task<CatalystResult> UnblockAsync(CatalystRelationshipRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystResult>("/catalyst/v1/blocks", request, cancellationToken);
    }

    #endregion

    #region Contest

    public async Task<IReadOnlyList<CatalystContest>> GetContestsByMeAsync(CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystContestsWrapper>("/catalyst/v1/contest/by/me", cancellationToken);
        return response.Contests;
    }

    public async Task<CatalystContest> GetContestBySlugAsync(string slug, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystContestWrapper>($"/catalyst/v1/contest/by/slug/{slug}", cancellationToken);
        return response.Contest;
    }

    public async Task<IReadOnlyList<CatalystStatus>> GetContestTimelineAsync(string slug, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatuses>($"/catalyst/v1/contest/by/slug/{slug}/timeline", cancellationToken);
        return response.Statuses;
    }

    public async Task<CatalystUserVoteRights> GetContestVotesAsync(string slug, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystUserVoteRights>($"/catalyst/v1/contest/by/slug/{slug}/vote", cancellationToken);
    }

    public async Task<CatalystResult> AddContestVoteAsync(string slug, string status, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystResult>($"/catalyst/v1/contest/by/slug/{slug}/vote/{status}", null, cancellationToken);
    }

    public async Task<CatalystResult> RemoveContestVoteAsync(string slug, string status, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystResult>($"/catalyst/v1/contest/by/slug/{slug}/vote/{status}", cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystContest>> GetContestsByUserAsync(string userId, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystContestsWrapper>($"/catalyst/v1/contest/by/user/{userId}", cancellationToken);
        return response.Contests;
    }

    public async Task<IReadOnlyList<CatalystContest>> GetCurrentContestsAsync(CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystContestsWrapper>("/catalyst/v1/contest/current", cancellationToken);
        return response.Contests;
    }

    public async Task<IReadOnlyList<CatalystContest>> SearchContestsAsync(string? query = null, string? state = null, string? id = null, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystContestsWrapper>("/catalyst/v1/contest/search", new Dictionary<string, string?>
        {
            ["q"] = query,
            ["state"] = state,
            ["id"] = id
        }, cancellationToken);
        return response.Contests;
    }

    #endregion

    #region CustomReactions

    public async Task<CatalystCustomReactionList> GetCustomUserReactionsAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystCustomReactionList>("/catalyst/v1/custom-reactions", cancellationToken);
    }

    public async Task<CatalystUserCustomReaction> CreateCustomReactionAsync(MultipartFormDataContent content, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostMultipartAsync<CatalystUserCustomReaction>("/catalyst/v1/custom-reactions", content, cancellationToken);
    }

    public async Task<CatalystUserCustomReaction> UpdateCustomReactionAsync(string id, CatalystUpdateCustomReactionRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PatchAsync<CatalystUserCustomReaction>($"/catalyst/v1/custom-reactions/{id}", request, cancellationToken);
    }

    public async Task DeleteCustomReactionAsync(string id, CancellationToken cancellationToken = default)
    {
        await _httpClient.DeleteAsync($"/catalyst/v1/custom-reactions/{id}", cancellationToken);
    }

    #endregion

    #region Fleet

    public async Task<Identity> CreateFleetAsync(CatalystCreateFleetRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<Identity>("/catalyst/v1/fleet", request, cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystFleet>> GetFleetByUsernameAsync(string username, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystFleet>>($"/catalyst/v1/fleet/by/user/{username}", cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystFleetRing>> GetFleetsAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystFleetRing>>("/catalyst/v1/fleet/ring", cancellationToken);
    }

    public async Task<CatalystFleet> GetFleetByIdAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystFleet>($"/catalyst/v1/fleet/{id}", cancellationToken);
    }

    public async Task<CatalystResult> DeleteFleetAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystResult>($"/catalyst/v1/fleet/{id}", cancellationToken);
    }

    public async Task<CatalystReactionValue> ReactFleetAsync(string id, string symbol, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystReactionValue>($"/catalyst/v1/fleet/{id}/reactions/{symbol}", null, cancellationToken);
    }

    public async Task<CatalystReactionValue> UnreactFleetAsync(string id, string symbol, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystReactionValue>($"/catalyst/v1/fleet/{id}/reactions/{symbol}", cancellationToken);
    }

    public async Task<CatalystResult> ViewFleetAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystResult>($"/catalyst/v1/fleet/{id}/view", null, cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystFleetViewer>> GetFleetViewersAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystFleetViewer>>($"/catalyst/v1/fleet/{id}/viewers", cancellationToken);
    }

    #endregion

    #region Privacy

    public async Task<CatalystPrivacySettings> GetPrivacySettingsAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystPrivacySettings>("/catalyst/v1/privacy/settings", cancellationToken);
    }

    public async Task<CatalystPrivacySettings> UpdatePrivacySettingsAsync(CatalystPrivacySettings request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PatchAsync<CatalystPrivacySettings>("/catalyst/v1/privacy/settings", request, cancellationToken);
    }

    #endregion

    #region ProfileTags

    public async Task<IReadOnlyList<CatalystProfileTag>> UpdateProfileTagsAsync(CatalystUpdateProfileTagsRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.PutAsync<CatalystProfileTagsWrapper>("/catalyst/v1/profile-tags", request, cancellationToken);
        return response.Tags;
    }

    public async Task<CatalystProfileTagUsersResult> GetUsersByProfileTagAsync(string name, string? cursor = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystProfileTagUsersResult>($"/catalyst/v1/profile-tags/by/name/{name}/users", new Dictionary<string, string?>
        {
            ["cursor"] = cursor
        }, cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystProfileTag>> GetProfileTagsByUserAsync(string userId, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystProfileTagsWrapper>($"/catalyst/v1/profile-tags/by/user/{userId}", cancellationToken);
        return response.Tags;
    }

    public async Task<IReadOnlyList<CatalystProfileTagSuggestion>> GetProfileTagSuggestionsAsync(string query, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystProfileTagSuggestionsWrapper>("/catalyst/v1/profile-tags/suggestions", new Dictionary<string, string?>
        {
            ["q"] = query
        }, cancellationToken);
        return response.Tags;
    }

    #endregion

    #region Random

    public async Task<CatalystStatus?> GetRandomStatusAsync(CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystNullableStatusV1Wrapper>("/catalyst/v1/random", cancellationToken);
        return response.Status;
    }

    public async Task<CatalystStatusV1_1> GetRandomStatusV1_1Async(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystStatusV1_1>("/catalyst/v1.1/random", cancellationToken);
    }

    public async Task<CatalystStatusV1_1> GetOnThisDayAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystStatusV1_1>("/catalyst/v1.1/on-this-day", cancellationToken);
    }

    #endregion

    #region Reactions

    public async Task<IReadOnlyList<CatalystCustomReaction>> GetOriginalReactionsAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystCustomReaction>>("/catalyst/v1/reactions", cancellationToken);
    }

    #endregion

    #region Relationships

    public async Task<CatalystResult> FollowAsync(CatalystRelationshipRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystResult>("/catalyst/v1/relationships", request, cancellationToken);
    }

    public async Task<CatalystResult> RemoveAsync(CatalystRelationshipRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystResult>("/catalyst/v1/relationships", request, cancellationToken);
    }

    public async Task<CatalystRelationshipsCount> GetRelationshipCountsAsync(string username, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystRelationshipsCount>($"/catalyst/v1/relationships/by/username/{username}/counts", cancellationToken);
    }

    public async Task<CatalystFollowingOrFollowersList> GetFollowersAsync(string username, int? page = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystFollowingOrFollowersList>($"/catalyst/v1/relationships/by/username/{username}/followers", new Dictionary<string, string?>
        {
            ["page"] = page?.ToString()
        }, cancellationToken);
    }

    public async Task<CatalystFollowingOrFollowersList> GetFollowingsAsync(string username, int? page = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystFollowingOrFollowersList>($"/catalyst/v1/relationships/by/username/{username}/followings", new Dictionary<string, string?>
        {
            ["page"] = page?.ToString()
        }, cancellationToken);
    }

    public async Task<CatalystRelationships> GetRelationshipsAsync(string userId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystRelationships>($"/catalyst/v1/relationships/{userId}", cancellationToken);
    }

    #endregion

    #region SmartAlbum

    public async Task<Identity> CreateSmartAlbumAsync(CatalystCreateSmartAlbumRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<Identity>("/catalyst/v1/smart-album", request, cancellationToken);
    }

    public async Task<CatalystSmartAlbum> GetSmartAlbumAsync(string id, int? limit = null, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbum>($"/catalyst/v1/smart-album/by/id/{id}", new Dictionary<string, string?>
        {
            ["limit"] = limit?.ToString(),
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task<CatalystSmartAlbum> EditSmartAlbumAsync(string id, CatalystEditSmartAlbumRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PatchAsync<CatalystSmartAlbum>($"/catalyst/v1/smart-album/by/id/{id}", request, cancellationToken);
    }

    public async Task<CatalystResult> DeleteSmartAlbumAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystResult>($"/catalyst/v1/smart-album/by/id/{id}", cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystAlbumBook>> GetSmartAlbumBooksAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystAlbumBook>>($"/catalyst/v1/smart-album/by/id/{id}/book", cancellationToken);
    }

    public async Task<CatalystAlbumBook> CreateSmartAlbumBookAsync(string id, CatalystCreateAlbumBookRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystAlbumBook>($"/catalyst/v1/smart-album/by/id/{id}/book", request, cancellationToken);
    }

    public async Task<CatalystAlbumBook> GetSmartAlbumBookAsync(string id, string bookId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystAlbumBook>($"/catalyst/v1/smart-album/by/id/{id}/book/{bookId}", cancellationToken);
    }

    public async Task<CatalystAlbumBook> RegenerateSmartAlbumBookAsync(string id, string bookId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystAlbumBook>($"/catalyst/v1/smart-album/by/id/{id}/book/{bookId}/regenerate", null, cancellationToken);
    }

    public async Task<CatalystSmartAlbums> GetSmartAlbumsByUserAsync(string userId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbums>($"/catalyst/v1/smart-album/by/user/{userId}", cancellationToken);
    }

    public async Task<CatalystSmartAlbums> SearchSmartAlbumsAsync(string? query = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbums>("/catalyst/v1/smart-album/search", new Dictionary<string, string?>
        {
            ["q"] = query
        }, cancellationToken);
    }

    #endregion

    #region Status

    public async Task<Identity> CreateStatusAsync(CatalystCreateStatusRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<Identity>("/catalyst/v1/status", request, cancellationToken);
    }

    public async Task<CatalystStatus> GetStatusAsync(string id, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatusV1Wrapper>($"/catalyst/v1/status/{id}", cancellationToken);
        return response.Status;
    }

    public async Task<CatalystStatusV1_1> GetStatusV1_1Async(string id, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatusWrapper>($"/catalyst/v1.1/status/{id}", cancellationToken);
        return response.Status;
    }

    public async Task<Identity> EditStatusAsync(string id, CatalystEditStatusRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PatchAsync<Identity>($"/catalyst/v1/status/{id}", request, cancellationToken);
    }

    public async Task<CatalystMessage> DeleteStatusAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystMessage>($"/catalyst/v1/status/{id}", cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystAlbum>> GetAlbumsInStatusAsync(string id, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystAlbumsWrapper>($"/catalyst/v1/status/{id}/albums", cancellationToken);
        return response.Albums;
    }

    public async Task<bool> IsFavoritedAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<bool>($"/catalyst/v1/status/{id}/favorite", cancellationToken);
    }

    public async Task<CatalystResult> FavoriteAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystResult>($"/catalyst/v1/status/{id}/favorite", null, cancellationToken);
    }

    public async Task<CatalystResult> UnfavoriteAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystResult>($"/catalyst/v1/status/{id}/favorite", cancellationToken);
    }

    public async Task<CatalystReactions> GetReactionsAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystReactions>($"/catalyst/v1/status/{id}/reactions", cancellationToken);
    }

    public async Task ReactWithCustomReactionAsync(string id, string customReactionId, CancellationToken cancellationToken = default)
    {
        await _httpClient.PostAsync($"/catalyst/v1/status/{id}/reactions/custom/{customReactionId}", null, cancellationToken);
    }

    public async Task UnreactWithCustomReactionAsync(string id, string customReactionId, CancellationToken cancellationToken = default)
    {
        await _httpClient.DeleteAsync($"/catalyst/v1/status/{id}/reactions/custom/{customReactionId}", cancellationToken);
    }

    public async Task<CatalystReactionValue> ReactAsync(string id, string symbol, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystReactionValue>($"/catalyst/v1/status/{id}/reactions/{symbol}", null, cancellationToken);
    }

    public async Task<CatalystReactionValue> UnreactAsync(string id, string symbol, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<CatalystReactionValue>($"/catalyst/v1/status/{id}/reactions/{symbol}", cancellationToken);
    }

    public async Task<Identity> ReportStatusAsync(string id, CatalystCreateReportRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<Identity>($"/catalyst/v1/status/{id}/report", request, cancellationToken);
    }

    #endregion

    #region BulkStatusReactions

    public async Task<CatalystBulkStatusReactions> GetBulkStatusReactionsAsync(IReadOnlyList<string> ids, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<CatalystBulkStatusReactions>("/catalyst/v1/statuses/reactions", new CatalystBulkStatusReactionsRequest(ids), cancellationToken);
    }

    #endregion

    #region Timeline

    public async Task<IReadOnlyList<CatalystStatus>> GetArchiveTimelineAsync(int year, int month, int? day = null, string? since = null, string? until = null, string? userId = null, int? limit = null, bool? excludeSensitive = null, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatuses>("/catalyst/v1/timeline/archive", new Dictionary<string, string?>
        {
            ["year"] = year.ToString(),
            ["month"] = month.ToString(),
            ["day"] = day?.ToString(),
            ["since"] = since,
            ["until"] = until,
            ["userId"] = userId,
            ["limit"] = limit?.ToString(),
            ["excludeSensitive"] = excludeSensitive?.ToString().ToLowerInvariant()
        }, cancellationToken);
        return response.Statuses;
    }

    public async Task<CatalystArchiveMonths> GetArchiveMonthsAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystArchiveMonths>("/catalyst/v1/timeline/archive/months", cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystStatus>> GetTimelineByContestSlugAsync(string slug, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatuses>($"/catalyst/v1/timeline/contest/by/slug/{slug}", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
        return response.Statuses;
    }

    public async Task<IReadOnlyList<CatalystStatusV1_1>> GetFavoriteTimelineAsync(string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatusesV1_1>("/catalyst/v1/timeline/favorite", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
        return response.Statuses;
    }

    public async Task<IReadOnlyList<CatalystStatus>> GetFirehoseTimelineV1Async(string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatuses>("/catalyst/v1/timeline/firehose", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
        return response.Statuses;
    }

    public async Task<IReadOnlyList<CatalystStatus>> GetGalleryTimelineAsync(string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatuses>("/catalyst/v1/timeline/gallery", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
        return response.Statuses;
    }

    public async Task<IReadOnlyList<CatalystStatus>> GetHomeTimelineV1Async(CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatuses>("/catalyst/v1/timeline/home", cancellationToken);
        return response.Statuses;
    }

    public async Task<IReadOnlyList<CatalystStatus>> SearchTimelineAsync(string? query = null, bool? exact = null, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatuses>("/catalyst/v1/timeline/search", new Dictionary<string, string?>
        {
            ["q"] = query,
            ["exact"] = exact?.ToString().ToLowerInvariant(),
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
        return response.Statuses;
    }

    public async Task<IReadOnlyList<CatalystStatus>> GetUserTimelineAsync(string username, string? since = null, string? until = null, int? limit = null, bool? excludeSensitive = null, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatuses>($"/catalyst/v1/timeline/user/by/username/{username}", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until,
            ["limit"] = limit?.ToString(),
            ["exclude_sensitive"] = excludeSensitive?.ToString().ToLowerInvariant()
        }, cancellationToken);
        return response.Statuses;
    }

    public async Task<IReadOnlyList<CatalystStatus>> GetUserGalleryTimelineAsync(string username, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystStatuses>($"/catalyst/v1/timeline/user/by/username/{username}/gallery", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
        return response.Statuses;
    }

    public async Task<IReadOnlyList<CatalystStatusV1_1>> GetFirehoseTimelineAsync(string? since = null, string? until = null, bool? trimVisitor = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystStatusV1_1>>("/catalyst/v1.1/timeline/firehose", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until,
            ["trim_visitor"] = trimVisitor?.ToString().ToLowerInvariant()
        }, cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystStatusV1_1>> GetHomeTimelineAsync(string? since = null, string? until = null, bool? trimVisitor = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystStatusV1_1>>("/catalyst/v1.1/timeline/home", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until,
            ["trim_visitor"] = trimVisitor?.ToString().ToLowerInvariant()
        }, cancellationToken);
    }

    #endregion

    #region Trend

    public async Task<IReadOnlyList<string>?> GetTrendsAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<string>?>("/catalyst/v1/trend", cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystRichTrendingItem>?> GetRichTrendsAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystRichTrendingItem>?>("/catalyst/v1/trend", new Dictionary<string, string?>
        {
            ["format"] = "rich"
        }, cancellationToken);
    }

    #endregion
}
