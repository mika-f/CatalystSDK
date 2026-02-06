using CatalystSharp.Http;
using CatalystSharp.Models;
using CatalystSharp.Models.Requests;

namespace CatalystSharp.Clients;

public class EgeriaClient
{
    private readonly ICatalystHttpClient _httpClient;

    internal EgeriaClient(ICatalystHttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<EgeriaUserWrapper?> GetCurrentUserAsync(CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<EgeriaUserWrapper?>("/egeria/v1/me", cancellationToken);
    }

    public async Task UpdateProfileAsync(EgeriaUpdateProfileRequest request, CancellationToken cancellationToken = default)
    {
        await _httpClient.PatchAsync("/egeria/v1/me", request, cancellationToken);
    }

    public async Task<EgeriaUsers> SearchUsersAsync(string query, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<EgeriaUsers>("/egeria/v1/search", new Dictionary<string, string?>
        {
            ["q"] = query
        }, cancellationToken);
    }

    public async Task<EgeriaUserWrapper?> GetUserByIdAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<EgeriaUserWrapper?>($"/egeria/v1/user/by/id/{id}", cancellationToken);
    }

    public async Task<EgeriaUserWrapper?> GetUserByUsernameAsync(string username, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<EgeriaUserWrapper?>($"/egeria/v1/user/by/username/{username}", cancellationToken);
    }
}
