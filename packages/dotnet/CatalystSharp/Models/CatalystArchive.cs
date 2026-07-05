using System.Text.Json.Serialization;

namespace CatalystSharp.Models;

public record CatalystArchiveMonth(
    [property: JsonPropertyName("year")] int Year,
    [property: JsonPropertyName("month")] int Month,
    [property: JsonPropertyName("count")] int Count
);

public record CatalystArchiveMonths(
    [property: JsonPropertyName("months")] IReadOnlyList<CatalystArchiveMonth> Months
);
