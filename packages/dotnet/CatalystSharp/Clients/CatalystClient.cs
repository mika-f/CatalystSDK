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

    public async Task<CatalystAlbum> GetAlbumAsync(string id, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystAlbum>($"/catalyst/v1/album/by/id/{id}", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task EditAlbumAsync(string id, CatalystEditAlbumRequest request, CancellationToken cancellationToken = default)
    {
        await _httpClient.PatchAsync($"/catalyst/v1/album/by/id/{id}", request, cancellationToken);
    }

    public async Task InsertToAlbumAsync(string id, CatalystInsertToAlbumRequest request, CancellationToken cancellationToken = default)
    {
        await _httpClient.PutAsync($"/catalyst/v1/album/by/id/{id}", request, cancellationToken);
    }

    public async Task RemoveFromAlbumAsync(string id, CatalystRemoveFromAlbumRequest request, CancellationToken cancellationToken = default)
    {
        await _httpClient.PutAsync($"/catalyst/v1/album/by/id/{id}", request, cancellationToken);
    }

    public async Task DeleteAlbumAsync(string id, CancellationToken cancellationToken = default)
    {
        await _httpClient.DeleteAsync($"/catalyst/v1/album/by/id/{id}", cancellationToken);
    }

    public async Task<CatalystSmartAlbums> ListAlbumsAsync(string username, bool includeSmartAlbums = true, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbums>($"/catalyst/v1/album/by/user/{username}", new Dictionary<string, string?>
        {
            ["include_smart_albums"] = includeSmartAlbums ? "true" : "false"
        }, cancellationToken);
    }

    public async Task<CatalystSmartAlbums> SearchAlbumsAsync(string query, bool includeSmartAlbums = true, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbums>("/catalyst/v1/album/search", new Dictionary<string, string?>
        {
            ["q"] = query,
            ["include_smart_album"] = includeSmartAlbums ? "true" : "false"
        }, cancellationToken);
    }

    #endregion

    #region SmartAlbum

    public async Task<Identity> CreateSmartAlbumAsync(CatalystCreateSmartAlbumRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<Identity>("/catalyst/v1/smart-album", request, cancellationToken);
    }

    public async Task<CatalystSmartAlbum> GetSmartAlbumAsync(string id, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbum>($"/catalyst/v1/smart-album/by/id/{id}", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task EditSmartAlbumAsync(string id, CatalystEditSmartAlbumRequest request, CancellationToken cancellationToken = default)
    {
        await _httpClient.PatchAsync($"/catalyst/v1/smart-album/by/id/{id}", request, cancellationToken);
    }

    public async Task DeleteSmartAlbumAsync(string id, CancellationToken cancellationToken = default)
    {
        await _httpClient.DeleteAsync($"/catalyst/v1/smart-album/by/id/{id}", cancellationToken);
    }

    public async Task<CatalystSmartAlbums> SearchSmartAlbumsAsync(string query, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystSmartAlbums>("/catalyst/v1/smart-album/search", new Dictionary<string, string?>
        {
            ["q"] = query
        }, cancellationToken);
    }

    #endregion

    #region Reactions

    public async Task<IReadOnlyList<CatalystCustomReaction>> GetCustomReactionsAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystCustomReaction>>("/catalyst/v1/reactions", cancellationToken);
    }

    #endregion

    #region Relationships

    public async Task<CatalystRelationships> GetRelationshipsAsync(string userId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystRelationships>($"/catalyst/v1/relationships/{userId}", cancellationToken);
    }

    public async Task FollowAsync(CatalystRelationshipRequest request, CancellationToken cancellationToken = default)
    {
        await _httpClient.PostAsync("/catalyst/v1/relationships", request, cancellationToken);
    }

    public async Task RemoveAsync(CatalystRelationshipRequest request, CancellationToken cancellationToken = default)
    {
        await _httpClient.DeleteAsync("/catalyst/v1/relationships", request, cancellationToken);
    }

    #endregion

    #region Status

    public async Task<Identity> CreateStatusAsync(CatalystCreateStatusRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<Identity>("/catalyst/v1/status", request, cancellationToken);
    }

    public async Task<CatalystStatusWrapper> GetStatusAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystStatusWrapper>($"/catalyst/v1.1/status/{id}", cancellationToken);
    }

    public async Task EditStatusAsync(string id, CatalystEditStatusRequest request, CancellationToken cancellationToken = default)
    {
        await _httpClient.PatchAsync($"/catalyst/v1/status/{id}", request, cancellationToken);
    }

    public async Task DeleteStatusAsync(string id, CancellationToken cancellationToken = default)
    {
        await _httpClient.DeleteAsync($"/catalyst/v1/status/{id}", cancellationToken);
    }

    public async Task<bool> IsFavoritedAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<bool>($"/catalyst/v1/status/{id}/favorite", cancellationToken);
    }

    public async Task FavoriteAsync(string id, CancellationToken cancellationToken = default)
    {
        await _httpClient.PostAsync($"/catalyst/v1/status/{id}/favorite", null, cancellationToken);
    }

    public async Task UnfavoriteAsync(string id, CancellationToken cancellationToken = default)
    {
        await _httpClient.DeleteAsync($"/catalyst/v1/status/{id}/favorite", cancellationToken);
    }

    public async Task<CatalystReactions> GetReactionsAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystReactions>($"/catalyst/v1/status/{id}/reactions", cancellationToken);
    }

    public async Task ReactAsync(string id, string symbol, CancellationToken cancellationToken = default)
    {
        await _httpClient.PostAsync($"/catalyst/v1/status/{id}/reactions/{symbol}", null, cancellationToken);
    }

    public async Task UnreactAsync(string id, string symbol, CancellationToken cancellationToken = default)
    {
        await _httpClient.DeleteAsync($"/catalyst/v1/status/{id}/reactions/{symbol}", cancellationToken);
    }

    #endregion

    #region Timeline

    public async Task<CatalystStatuses> GetContestTimelineAsync(string slug, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystStatuses>($"/catalyst/v1/timeline/contest/by/slug/{slug}", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task<CatalystStatuses> GetFavoriteTimelineAsync(string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystStatuses>("/catalyst/v1/timeline/favorite", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystStatus>> GetFirehoseTimelineAsync(string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystStatus>>("/catalyst/v1.1/timeline/firehose", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task<CatalystStatuses> GetGalleryTimelineAsync(string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystStatuses>("/catalyst/v1/timeline/gallery", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task<IReadOnlyList<CatalystStatus>> GetHomeTimelineAsync(string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<CatalystStatus>>("/catalyst/v1.1/timeline/home", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task<CatalystStatuses> SearchTimelineAsync(string? query = null, bool? exact = null, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystStatuses>("/catalyst/v1/timeline/search", new Dictionary<string, string?>
        {
            ["q"] = query,
            ["exact"] = exact?.ToString().ToLowerInvariant(),
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task<CatalystStatuses> GetUserTimelineAsync(string username, bool? trimUser = null, bool? excludeSensitive = null, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystStatuses>($"/catalyst/v1/timeline/user/by/username/{username}", new Dictionary<string, string?>
        {
            ["trim_user"] = trimUser?.ToString().ToLowerInvariant(),
            ["exclude_sensitive"] = excludeSensitive?.ToString().ToLowerInvariant(),
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task<CatalystStatuses> GetUserGalleryTimelineAsync(string username, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<CatalystStatuses>($"/catalyst/v1/timeline/user/by/username/{username}/gallery", new Dictionary<string, string?>
        {
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    #endregion

    #region Trend

    public async Task<IReadOnlyList<string>> GetTrendsAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyList<string>>("/catalyst/v1/trend", cancellationToken);
    }

    #endregion
}
