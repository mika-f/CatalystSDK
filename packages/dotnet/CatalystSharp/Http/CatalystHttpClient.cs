using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Web;
using CatalystSharp.Exceptions;

namespace CatalystSharp.Http;

internal class CatalystHttpClient : ICatalystHttpClient
{
    private readonly HttpClient _httpClient;
    private readonly JsonSerializerOptions _jsonOptions;
    private string? _accessToken;

    public CatalystHttpClient(HttpClient httpClient)
    {
        _httpClient = httpClient;
        _jsonOptions = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
            Converters = { new JsonStringEnumConverter(JsonNamingPolicy.CamelCase) }
        };
    }

    public void SetAccessToken(string? accessToken)
    {
        _accessToken = accessToken;
    }

    public async Task<T> GetAsync<T>(string path, CancellationToken cancellationToken = default)
    {
        return await GetAsync<T>(path, null, cancellationToken);
    }

    public async Task<T> GetAsync<T>(string path, IDictionary<string, string?>? queryParams, CancellationToken cancellationToken = default)
    {
        var url = BuildUrl(path, queryParams);
        using var request = CreateRequest(HttpMethod.Get, url);
        return await SendAsync<T>(request, cancellationToken);
    }

    public async Task<T> PostAsync<T>(string path, object? body = null, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Post, BuildUrl(path));
        if (body != null)
        {
            request.Content = CreateJsonContent(body);
        }
        return await SendAsync<T>(request, cancellationToken);
    }

    public async Task PostAsync(string path, object? body = null, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Post, BuildUrl(path));
        if (body != null)
        {
            request.Content = CreateJsonContent(body);
        }
        await SendAsync(request, cancellationToken);
    }

    public async Task<T> PatchAsync<T>(string path, object? body = null, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Patch, BuildUrl(path));
        if (body != null)
        {
            request.Content = CreateJsonContent(body);
        }
        return await SendAsync<T>(request, cancellationToken);
    }

    public async Task PatchAsync(string path, object? body = null, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Patch, BuildUrl(path));
        if (body != null)
        {
            request.Content = CreateJsonContent(body);
        }
        await SendAsync(request, cancellationToken);
    }

    public async Task<T> PutAsync<T>(string path, object? body = null, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Put, BuildUrl(path));
        if (body != null)
        {
            request.Content = CreateJsonContent(body);
        }
        return await SendAsync<T>(request, cancellationToken);
    }

    public async Task PutAsync(string path, object? body = null, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Put, BuildUrl(path));
        if (body != null)
        {
            request.Content = CreateJsonContent(body);
        }
        await SendAsync(request, cancellationToken);
    }

    public async Task DeleteAsync(string path, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Delete, BuildUrl(path));
        await SendAsync(request, cancellationToken);
    }

    public async Task DeleteAsync(string path, object? body, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Delete, BuildUrl(path));
        if (body != null)
        {
            request.Content = CreateJsonContent(body);
        }
        await SendAsync(request, cancellationToken);
    }

    public async Task<byte[]> GetBytesAsync(string path, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Get, BuildUrl(path));
        var response = await _httpClient.SendAsync(request, cancellationToken);
        await EnsureSuccessAsync(response, cancellationToken);
        return await response.Content.ReadAsByteArrayAsync(cancellationToken);
    }

    public async Task<byte[]> PostBytesAsync(string path, object? body = null, CancellationToken cancellationToken = default)
    {
        using var request = CreateRequest(HttpMethod.Post, BuildUrl(path));
        if (body != null)
        {
            request.Content = CreateJsonContent(body);
        }
        var response = await _httpClient.SendAsync(request, cancellationToken);
        await EnsureSuccessAsync(response, cancellationToken);
        return await response.Content.ReadAsByteArrayAsync(cancellationToken);
    }

    private static string BuildUrl(string path, IDictionary<string, string?>? queryParams = null)
    {
        var url = $"{CatalystConstants.ApiEndpoint}{path}";

        if (queryParams == null || queryParams.Count == 0)
        {
            return url;
        }

        var query = HttpUtility.ParseQueryString(string.Empty);
        foreach (var (key, value) in queryParams)
        {
            if (value != null)
            {
                query[key] = value;
            }
        }

        var queryString = query.ToString();
        return string.IsNullOrEmpty(queryString) ? url : $"{url}?{queryString}";
    }

    private HttpRequestMessage CreateRequest(HttpMethod method, string url)
    {
        var request = new HttpRequestMessage(method, url);

        if (!string.IsNullOrEmpty(_accessToken))
        {
            request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", _accessToken);
        }

        return request;
    }

    private StringContent CreateJsonContent(object body)
    {
        var json = JsonSerializer.Serialize(body, _jsonOptions);
        return new StringContent(json, Encoding.UTF8, "application/json");
    }

    private async Task<T> SendAsync<T>(HttpRequestMessage request, CancellationToken cancellationToken)
    {
        var response = await _httpClient.SendAsync(request, cancellationToken);
        await EnsureSuccessAsync(response, cancellationToken);

        var content = await response.Content.ReadAsStringAsync(cancellationToken);
        return JsonSerializer.Deserialize<T>(content, _jsonOptions)
            ?? throw new CatalystException("Failed to deserialize response");
    }

    private async Task SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
    {
        var response = await _httpClient.SendAsync(request, cancellationToken);
        await EnsureSuccessAsync(response, cancellationToken);
    }

    private static async Task EnsureSuccessAsync(HttpResponseMessage response, CancellationToken cancellationToken)
    {
        if (response.IsSuccessStatusCode)
        {
            return;
        }

        var content = await response.Content.ReadAsStringAsync(cancellationToken);
        var statusCode = (int)response.StatusCode;

        throw statusCode switch
        {
            400 => new BadRequestException(content),
            401 => new UnauthorizedException(content),
            403 => new ForbiddenException(content),
            404 => new NotFoundException(content),
            409 => new ConflictException(content),
            >= 500 => new InternalServerErrorException(content),
            _ => new CatalystException($"HTTP {statusCode}: {content}", statusCode, content)
        };
    }
}
