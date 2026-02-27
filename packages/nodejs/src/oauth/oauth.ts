import { PUBLIC_API_ENDPOINT, PUBLIC_AUTHORIZE_ENDPOINT } from "../types/constants.js";
import type { Token } from "../types/token.js";
import type { PKCE } from "./pkce.js";

export class OAuthError extends Error {
  constructor(
    message: string,
    public readonly kind: "authorizationRequestFailed" | "invalidAuthorizationResponse" | "invalidTokenResponse",
    public readonly info?: { error: string; description?: string; uri?: string },
  ) {
    super(message);
    this.name = "OAuthError";
  }
}

export class OAuth {
  constructor(
    private readonly clientId: string,
    private readonly clientSecret: string,
  ) {}

  async getAccessTokenByCode(code: string, redirectUri: string, pkce: PKCE): Promise<Token> {
    const body = new URLSearchParams({
      grant_type: "authorization_code",
      code,
      redirect_uri: redirectUri,
      client_id: this.clientId,
      code_verifier: pkce.verifier,
    });

    return this.postToken(body);
  }

  async getAccessTokenByRefreshToken(refreshToken: string): Promise<Token> {
    const body = new URLSearchParams({
      grant_type: "refresh_token",
      refresh_token: refreshToken,
      client_id: this.clientId,
      client_secret: this.clientSecret,
    });

    return this.postToken(body);
  }

  getAuthorizeURL(redirectUri: string, pkce: PKCE, state: string): URL {
    const url = new URL(PUBLIC_AUTHORIZE_ENDPOINT);
    url.searchParams.set("response_type", "code");
    url.searchParams.set("client_id", this.clientId);
    url.searchParams.set("redirect_uri", redirectUri);
    url.searchParams.set("state", state);
    url.searchParams.set("code_challenge", pkce.challenge);
    url.searchParams.set("code_challenge_method", pkce.method);
    return url;
  }

  getAuthorizationCode(callbackUrl: URL, expectedState: string, expectedRedirectUri: string): string {
    this.verifyAuthorizationResponse(callbackUrl, expectedState, expectedRedirectUri);

    const error = callbackUrl.searchParams.get("error");
    if (error != null) {
      throw new OAuthError("Authorization request failed", "authorizationRequestFailed", {
        error,
        description: callbackUrl.searchParams.get("error_description") ?? undefined,
        uri: callbackUrl.searchParams.get("error_uri") ?? undefined,
      });
    }

    const code = callbackUrl.searchParams.get("code");
    if (code == null) throw new OAuthError("Invalid authorization response", "invalidAuthorizationResponse");

    return code;
  }

  private verifyAuthorizationResponse(url: URL, expectedState: string, expectedRedirectUri: string): void {
    if (!url.href.startsWith(expectedRedirectUri + "?")) {
      throw new OAuthError("Invalid authorization response", "invalidAuthorizationResponse");
    }

    if (url.searchParams.get("state") !== expectedState) {
      throw new OAuthError("Invalid authorization response", "invalidAuthorizationResponse");
    }
  }

  private async postToken(body: URLSearchParams): Promise<Token> {
    const response = await fetch(`${PUBLIC_API_ENDPOINT}/token`, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: body.toString(),
    });

    if (!response.ok) {
      throw new OAuthError("Invalid token response", "invalidTokenResponse");
    }

    const json = await response.json() as Record<string, string>;
    return {
      accessToken: json["access_token"]!,
      refreshToken: json["refresh_token"]!,
      tokenType: json["token_type"]!,
    };
  }
}
