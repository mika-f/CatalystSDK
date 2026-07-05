using CatalystSharp.Http;
using CatalystSharp.Models;
using CatalystSharp.Models.Requests;

namespace CatalystSharp.Clients;

public class MediaClient
{
    private readonly ICatalystHttpClient _httpClient;

    internal MediaClient(ICatalystHttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<MediaUploadUrls> GetUploadUrlAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<MediaUploadUrls>("/media/v1/upload", null, cancellationToken);
    }

    public async Task<bool> DeleteAsync(MediaDeleteRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.DeleteAsync<bool>("/media/v1/upload", request, cancellationToken);
    }

    public async Task<MediaUploadUrls> GetUploadUrlV2Async(CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<MediaUploadUrls>("/media/v2/upload", null, cancellationToken);
    }
}
