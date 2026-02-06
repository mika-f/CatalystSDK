using System.Text.Json.Serialization;

namespace CatalystSharp.Models.Requests;

public record CatalystRelationshipRequest(
    [property: JsonPropertyName("userId")] string UserId
);
