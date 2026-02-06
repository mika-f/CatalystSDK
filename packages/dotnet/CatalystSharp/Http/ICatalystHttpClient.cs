namespace CatalystSharp.Http;

internal interface ICatalystHttpClient
{
    void SetAccessToken(string? accessToken);

    Task<T> GetAsync<T>(string path, CancellationToken cancellationToken = default);
    Task<T> GetAsync<T>(string path, IDictionary<string, string?>? queryParams, CancellationToken cancellationToken = default);

    Task<T> PostAsync<T>(string path, object? body = null, CancellationToken cancellationToken = default);
    Task PostAsync(string path, object? body = null, CancellationToken cancellationToken = default);

    Task<T> PatchAsync<T>(string path, object? body = null, CancellationToken cancellationToken = default);
    Task PatchAsync(string path, object? body = null, CancellationToken cancellationToken = default);

    Task<T> PutAsync<T>(string path, object? body = null, CancellationToken cancellationToken = default);
    Task PutAsync(string path, object? body = null, CancellationToken cancellationToken = default);

    Task DeleteAsync(string path, CancellationToken cancellationToken = default);
    Task DeleteAsync(string path, object? body, CancellationToken cancellationToken = default);

    Task<byte[]> GetBytesAsync(string path, CancellationToken cancellationToken = default);
    Task<byte[]> PostBytesAsync(string path, object? body = null, CancellationToken cancellationToken = default);
}
