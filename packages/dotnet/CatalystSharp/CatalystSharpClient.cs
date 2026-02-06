using System.Text.Json;
using CatalystSharp.Auth;
using CatalystSharp.Clients;
using CatalystSharp.Http;
using CatalystSharp.Models;

namespace CatalystSharp;

public class CatalystSharpClient : IDisposable
{
    private readonly HttpClient _httpClient;
    private readonly CatalystHttpClient _catalystHttpClient;
    private readonly bool _disposeHttpClient;

    private CatalystClient? _catalyst;
    private EgeriaClient? _egeria;
    private MediaClient? _media;
    private SteambirdClient? _steambird;
    private OAuthClient? _oauth;

    public string ClientId { get; }
    public string ClientSecret { get; }

    public string? AccessToken { get; private set; }
    public string? RefreshToken { get; private set; }

    public CatalystClient Catalyst => _catalyst ??= new CatalystClient(_catalystHttpClient);
    public EgeriaClient Egeria => _egeria ??= new EgeriaClient(_catalystHttpClient);
    public MediaClient Media => _media ??= new MediaClient(_catalystHttpClient);
    public SteambirdClient Steambird => _steambird ??= new SteambirdClient(_catalystHttpClient);
    public OAuthClient OAuth => _oauth ??= new OAuthClient(_httpClient, ClientId, ClientSecret);

    public CatalystSharpClient(string clientId, string clientSecret)
        : this(clientId, clientSecret, new HttpClient(), disposeHttpClient: true)
    {
    }

    public CatalystSharpClient(string clientId, string clientSecret, HttpClient httpClient)
        : this(clientId, clientSecret, httpClient, disposeHttpClient: false)
    {
    }

    public CatalystSharpClient(string clientId, string clientSecret, string accessToken, string refreshToken)
        : this(clientId, clientSecret)
    {
        SetCredentials(accessToken, refreshToken);
    }

    public CatalystSharpClient(string clientId, string clientSecret, HttpClient httpClient, string accessToken, string refreshToken)
        : this(clientId, clientSecret, httpClient)
    {
        SetCredentials(accessToken, refreshToken);
    }

    private CatalystSharpClient(string clientId, string clientSecret, HttpClient httpClient, bool disposeHttpClient)
    {
        ClientId = clientId;
        ClientSecret = clientSecret;
        _httpClient = httpClient;
        _disposeHttpClient = disposeHttpClient;
        _catalystHttpClient = new CatalystHttpClient(_httpClient);
    }

    public void SetCredentials(string accessToken, string refreshToken)
    {
        AccessToken = accessToken;
        RefreshToken = refreshToken;
        _catalystHttpClient.SetAccessToken(accessToken);
    }

    public void SetCredentials(Token token)
    {
        SetCredentials(token.AccessToken, token.RefreshToken);
    }

    public void ClearCredentials()
    {
        AccessToken = null;
        RefreshToken = null;
        _catalystHttpClient.SetAccessToken(null);
    }

    public async Task<Token> RefreshAsync(CancellationToken cancellationToken = default)
    {
        if (string.IsNullOrEmpty(RefreshToken))
        {
            throw new InvalidOperationException("No refresh token available. Please authenticate first.");
        }

        var token = await OAuth.GetAccessTokenByRefreshTokenAsync(RefreshToken, cancellationToken);
        SetCredentials(token);
        return token;
    }

    public static T Decode<T>(byte[] data)
    {
        var options = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        };
        return JsonSerializer.Deserialize<T>(data, options)
            ?? throw new InvalidOperationException("Failed to decode data");
    }

    public static T Decode<T>(string json)
    {
        var options = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        };
        return JsonSerializer.Deserialize<T>(json, options)
            ?? throw new InvalidOperationException("Failed to decode data");
    }

    public void Dispose()
    {
        if (_disposeHttpClient)
        {
            _httpClient.Dispose();
        }
        GC.SuppressFinalize(this);
    }
}
