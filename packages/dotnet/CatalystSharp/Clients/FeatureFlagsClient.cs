using CatalystSharp.Http;
using CatalystSharp.Models;

namespace CatalystSharp.Clients;

public class FeatureFlagsClient
{
    private readonly ICatalystHttpClient _httpClient;

    internal FeatureFlagsClient(ICatalystHttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<IReadOnlyList<string>> GetMyFeatureFlagsAsync(CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.GetAsync<CatalystFeatureFlags>("/feature-flags/v1/me", cancellationToken);
        return response.Flags;
    }
}
