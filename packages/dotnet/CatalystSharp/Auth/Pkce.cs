using System.Security.Cryptography;
using System.Text;

namespace CatalystSharp.Auth;

public class Pkce
{
    public string Verifier { get; }
    public string Challenge { get; }
    public string Method => "S256";

    public Pkce()
    {
        Verifier = GenerateVerifier();
        Challenge = ComputeChallenge(Verifier);
    }

    private static string GenerateVerifier()
    {
        var bytes = RandomNumberGenerator.GetBytes(32);
        return Base64UrlEncode(bytes);
    }

    private static string ComputeChallenge(string verifier)
    {
        var bytes = SHA256.HashData(Encoding.UTF8.GetBytes(verifier));
        return Base64UrlEncode(bytes);
    }

    private static string Base64UrlEncode(byte[] bytes)
    {
        return Convert.ToBase64String(bytes)
            .Replace("+", "-")
            .Replace("/", "_")
            .TrimEnd('=');
    }
}
