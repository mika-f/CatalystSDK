using CatalystSharp.Http;
using CatalystSharp.Models;
using CatalystSharp.Models.Requests;

namespace CatalystSharp.Clients;

public class EpicleseClient
{
    private readonly ICatalystHttpClient _httpClient;

    internal EpicleseClient(ICatalystHttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<EpicleseAuthorsResult> GetAuthorsAsync(string? query = null, string? platform = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<EpicleseAuthorsResult>("/epiclese/v1/authors", new Dictionary<string, string?>
        {
            ["q"] = query,
            ["platform"] = platform
        }, cancellationToken);
    }

    public async Task<EpicleseAuthor> CreateAuthorAsync(CatalystCreateMetadataAuthorRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.PostAsync<EpicleseAuthorWrapper>("/epiclese/v1/authors", request, cancellationToken);
        return response.Author;
    }

    public async Task<IReadOnlyList<EpiclesePlatform>> GetPlatformsAsync(CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<EpiclesePlatformsWrapper>("/epiclese/v1/platforms", cancellationToken);
        return response.Platforms;
    }

    public async Task<EpiclesePlatform> GetPlatformAsync(string id, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<EpiclesePlatformWrapper>($"/epiclese/v1/platforms/{id}", cancellationToken);
        return response.Platform;
    }

    public async Task<IReadOnlyDictionary<string, EpicleseStatusMetadataTag>> GetStatusMetadataAsync(string statusId, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<IReadOnlyDictionary<string, EpicleseStatusMetadataTag>>($"/epiclese/v1/tag/by/status/{statusId}", cancellationToken);
    }

    public async Task<IReadOnlyDictionary<string, EpicleseStatusMetadataTag>> CreateStatusMetadataAsync(string statusId, IReadOnlyList<CatalystCreateStatusMetadataItem> request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<IReadOnlyDictionary<string, EpicleseStatusMetadataTag>>($"/epiclese/v1/tag/by/status/{statusId}", request, cancellationToken);
    }

    public async Task<EpicleseWorldsResult> GetWorldsAsync(string? query = null, string? platform = null, int? offset = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<EpicleseWorldsResult>("/epiclese/v1/worlds", new Dictionary<string, string?>
        {
            ["q"] = query,
            ["platform"] = platform,
            ["offset"] = offset?.ToString()
        }, cancellationToken);
    }

    public async Task<EpicleseWorld> CreateWorldAsync(CatalystCreateMetadataWorldRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.PostAsync<EpicleseWorldWrapper>("/epiclese/v1/worlds", request, cancellationToken);
        return response.World!;
    }

    public async Task<EpicleseWorld?> ResolveWorldAsync(string platform, string name, CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<EpicleseWorldWrapper>("/epiclese/v1/worlds/resolve", new Dictionary<string, string?>
        {
            ["platform"] = platform,
            ["name"] = name
        }, cancellationToken);
        return response.World;
    }
}
