using CatalystSharp.Http;
using CatalystSharp.Models;

namespace CatalystSharp.Clients;

public class SteambirdClient
{
    private readonly ICatalystHttpClient _httpClient;

    public const string IssuerCatalystSystemMessage = "natsuneko-laboratory:catalyst";
    public const string IssuerCatalystUserMessage = "natsuneko-laboratory:catalyst-message";
    public const string IssuerEgeriaSystemMessage = "natsuneko-laboratory:egeria";

    internal SteambirdClient(ICatalystHttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<Notifications> GetNotificationsAsync(string issuer, string? since = null, string? until = null, CancellationToken cancellationToken = default)
    {
        return await _httpClient.GetAsync<Notifications>("/steambird/v1/notifications", new Dictionary<string, string?>
        {
            ["issuer"] = issuer,
            ["since"] = since,
            ["until"] = until
        }, cancellationToken);
    }

    public async Task MarkAsReadAsync(string notificationId, CancellationToken cancellationToken = default)
    {
        await _httpClient.PostAsync($"/steambird/v1/notifications/{notificationId}", null, cancellationToken);
    }

    public async Task MarkAllAsReadAsync(string? issuer = null, CancellationToken cancellationToken = default)
    {
        await _httpClient.PostAsync("/steambird/v1/notifications/all", null, cancellationToken);
    }

    public async Task<NotificationUnreadCount> GetUnreadCountAsync(IEnumerable<string>? issuers = null, CancellationToken cancellationToken = default)
    {
        var queryParams = new Dictionary<string, string?>();
        if (issuers != null)
        {
            queryParams["issuers"] = string.Join(",", issuers);
        }

        return await _httpClient.GetAsync<NotificationUnreadCount>("/steambird/v1/notifications/unread", queryParams, cancellationToken);
    }
}
