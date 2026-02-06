using System.Text.Json;
using System.Web;
using CatalystSharp.Exceptions;
using CatalystSharp.Models;

namespace CatalystSharp.Auth;

public class OAuthClient
{
    private readonly HttpClient _httpClient;
    private readonly string _clientId;
    private readonly string _clientSecret;
    private readonly JsonSerializerOptions _jsonOptions;

    internal OAuthClient(HttpClient httpClient, string clientId, string clientSecret)
    {
        _httpClient = httpClient;
        _clientId = clientId;
        _clientSecret = clientSecret;
        _jsonOptions = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower
        };
    }

    public Uri GetAuthorizeUrl(string redirectUri, Pkce pkce, string state)
    {
        var query = HttpUtility.ParseQueryString(string.Empty);
        query["response_type"] = "code";
        query["client_id"] = _clientId;
        query["redirect_uri"] = redirectUri;
        query["state"] = state;
        query["code_challenge"] = pkce.Challenge;
        query["code_challenge_method"] = pkce.Method;

        return new Uri($"{CatalystConstants.AuthorizeEndpoint}?{query}");
    }

    public async Task<Token> GetAccessTokenByCodeAsync(string code, string redirectUri, Pkce pkce, CancellationToken cancellationToken = default)
    {
        var content = new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["grant_type"] = "authorization_code",
            ["code"] = code,
            ["redirect_uri"] = redirectUri,
            ["client_id"] = _clientId,
            ["code_verifier"] = pkce.Verifier
        });

        var response = await _httpClient.PostAsync($"{CatalystConstants.ApiEndpoint}/token", content, cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            var errorContent = await response.Content.ReadAsStringAsync(cancellationToken);
            throw new CatalystException($"Failed to get access token: {errorContent}", (int)response.StatusCode, errorContent);
        }

        var json = await response.Content.ReadAsStringAsync(cancellationToken);
        return JsonSerializer.Deserialize<Token>(json, _jsonOptions)
            ?? throw new CatalystException("Failed to deserialize token response");
    }

    public async Task<Token> GetAccessTokenByRefreshTokenAsync(string refreshToken, CancellationToken cancellationToken = default)
    {
        var content = new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["grant_type"] = "refresh_token",
            ["refresh_token"] = refreshToken,
            ["client_id"] = _clientId,
            ["client_secret"] = _clientSecret
        });

        var response = await _httpClient.PostAsync($"{CatalystConstants.ApiEndpoint}/token", content, cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            var errorContent = await response.Content.ReadAsStringAsync(cancellationToken);
            throw new CatalystException($"Failed to refresh access token: {errorContent}", (int)response.StatusCode, errorContent);
        }

        var json = await response.Content.ReadAsStringAsync(cancellationToken);
        return JsonSerializer.Deserialize<Token>(json, _jsonOptions)
            ?? throw new CatalystException("Failed to deserialize token response");
    }

    public static string? ExtractAuthorizationCode(Uri callbackUri, string expectedState)
    {
        var query = HttpUtility.ParseQueryString(callbackUri.Query);
        var state = query["state"];
        var code = query["code"];

        if (state != expectedState)
        {
            return null;
        }

        return code;
    }
}
