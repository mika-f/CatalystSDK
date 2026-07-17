import { AuthInterceptor } from "./interceptors/authInterceptor.js";
import { UserAgentInterceptor } from "./interceptors/userAgentInterceptor.js";
import { OAuth } from "./oauth/oauth.js";
import type { Interceptor } from "./interceptors/interceptor.js";
import type { Token } from "./types/token.js";
import {
  Catalyst,
  CatalystClient,
  Egeria,
  Epiclese,
  FeatureFlags,
  Media2 as Media,
  Steambird,
} from "./generated/sdk.gen.js";
import { client } from "./generated/client.gen.js";

export interface CatalystTSOptions {
  clientId: string;
  clientSecret: string;
  accessToken?: string;
  refreshToken?: string;
  interceptors?: Interceptor[];
}

export class CatalystTS {
  readonly clientId: string;
  readonly clientSecret: string;

  private _accessToken: string | undefined;
  private _refreshToken: string | undefined;
  private _refreshing: Promise<Token> | undefined;

  private readonly maxAuthRetryCount = 5;
  private readonly http: CatalystClient;

  constructor(opts: CatalystTSOptions) {
    this.clientId = opts.clientId;
    this.clientSecret = opts.clientSecret;
    this._accessToken = opts.accessToken;
    this._refreshToken = opts.refreshToken;

    const interceptors: Interceptor[] = [
      ...(opts.interceptors ?? []),
      new AuthInterceptor(() => Promise.resolve(this._accessToken)),
      new UserAgentInterceptor(),
    ];

    for (const interceptor of interceptors) {
      if (interceptor.onRequest)
        client.interceptors.request.use(interceptor.onRequest);
      if (interceptor.onResponse)
        client.interceptors.response.use(interceptor.onResponse);
      if (interceptor.onError)
        client.interceptors.error.use(interceptor.onError);
    }

    client.setConfig({ fetch: this.fetchWithAuthRetry });
    this.http = new CatalystClient({ client });
  }

  private readonly fetchWithAuthRetry: typeof fetch = async (input, init) => {
    const request = new Request(input, init);
    let response = await fetch(request.clone());

    for (
      let attempt = 0;
      attempt < this.maxAuthRetryCount &&
      response.status === 401 &&
      this._refreshToken != null;
      attempt++
    ) {
      try {
        await this.refreshShared();
      } catch {
        break;
      }

      const retryRequest = request.clone();
      if (this._accessToken != null) {
        retryRequest.headers.set(
          "Authorization",
          `Bearer ${this._accessToken}`,
        );
      }

      response = await fetch(retryRequest);
    }

    return response;
  };

  private refreshShared(): Promise<Token> {
    this._refreshing ??= this.refresh().finally(() => {
      this._refreshing = undefined;
    });
    return this._refreshing;
  }

  get accessToken(): string | undefined {
    return this._accessToken;
  }

  get refreshToken(): string | undefined {
    return this._refreshToken;
  }

  setCredential(accessToken: string, refreshToken: string): void {
    this._accessToken = accessToken;
    this._refreshToken = refreshToken;
  }

  async refresh(): Promise<Token> {
    if (this._refreshToken == null) throw new Error("refreshToken is not set");

    const token = await this.oauth.getAccessTokenByRefreshToken(
      this._refreshToken,
    );
    this._accessToken = token.accessToken;
    this._refreshToken = token.refreshToken;
    return token;
  }

  get oauth(): OAuth {
    return new OAuth(this.clientId, this.clientSecret);
  }

  get catalyst(): Catalyst {
    return this.http.catalyst.catalyst;
  }

  get egeria(): Egeria {
    return this.http.egeria.egeria;
  }

  get epiclese(): Epiclese {
    return this.http.epiclese.epiclese;
  }

  get featureFlags(): FeatureFlags {
    return this.http.featureFlags.featureFlags;
  }

  get media(): Media {
    return this.http.media.media;
  }

  get steambird(): Steambird {
    return this.http.steambird.steambird;
  }
}
