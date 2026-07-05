using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystBulkStatusReactionsRequest(
    [property: JsonPropertyName("ids")] IReadOnlyList<string> Ids
);
