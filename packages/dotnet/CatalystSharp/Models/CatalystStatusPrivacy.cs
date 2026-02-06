using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

[JsonConverter(typeof(JsonStringEnumConverter<CatalystStatusPrivacy>))]
public enum CatalystStatusPrivacy
{
    [JsonPropertyName("public")]
    Public,

    [JsonPropertyName("quiet_public")]
    QuietPublic,

    [JsonPropertyName("followers")]
    Followers,

    [JsonPropertyName("private")]
    Private
}
