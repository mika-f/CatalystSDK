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

    public async Task<byte[]> DownloadAsync(MediaDownloadRequest request, CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostBytesAsync("/media/v1/download", request, cancellationToken);
    }

    public async Task DeleteAsync(MediaDeleteRequest request, CancellationToken cancellationToken = default)
    {
        await _httpClient.DeleteAsync("/media/v1/upload", request, cancellationToken);
    }

    public async Task<MediaUploadUrls> GetUploadUrlAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.PostAsync<MediaUploadUrls>("/media/v2/upload", null, cancellationToken);
    }
}
