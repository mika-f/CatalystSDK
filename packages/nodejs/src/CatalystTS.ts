import { AuthInterceptor } from "./interceptors/authInterceptor.js";
import { UserAgentInterceptor } from "./interceptors/userAgentInterceptor.js";
import { OAuth } from "./oauth/oauth.js";
import type { Interceptor } from "./interceptors/interceptor.js";
import type { Token } from "./types/token.js";
import {
  Catalyst2,
  CatalystClient,
  Egeria2,
  Epiclese2,
  FeatureFlags2,
  Media2,
  Steambird2,
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
      if (interceptor.onRequest) client.interceptors.request.use(interceptor.onRequest);
      if (interceptor.onResponse) client.interceptors.response.use(interceptor.onResponse);
      if (interceptor.onError) client.interceptors.error.use(interceptor.onError);
    }

    this.http = new CatalystClient({ client });
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

  get catalyst(): Catalyst2 {
    return this.http.catalyst;
  }

  get egeria(): Egeria2 {
    return this.http.egeria;
  }

  get epiclese(): Epiclese2 {
    return this.http.epiclese;
  }

  get featureFlags(): FeatureFlags2 {
    return this.http.featureFlags;
  }

  get media(): Media2 {
    return this.http.media;
  }

  get steambird(): Steambird2 {
    return this.http.steambird;
  }
}
