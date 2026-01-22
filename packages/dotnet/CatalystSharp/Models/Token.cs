using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record Token(
    [property: JsonPropertyName("access_token")] string AccessToken,
    [property: JsonPropertyName("refresh_token")] string RefreshToken,
    [property: JsonPropertyName("token_type")] string TokenType
);
