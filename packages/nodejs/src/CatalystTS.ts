import { HttpClient } from "./clients/httpClient.js";
import { CatalystClient } from "./clients/catalystClient.js";
import { EgeriaClient } from "./clients/egeriaClient.js";
import { MediaClient } from "./clients/mediaClient.js";
import { SteambirdClient } from "./clients/steambirdClient.js";
import { AuthInterceptor } from "./interceptors/authInterceptor.js";
import { UserAgentInterceptor } from "./interceptors/userAgentInterceptor.js";
import { OAuth } from "./oauth/oauth.js";
import type { RequestInterceptor } from "./interceptors/requestInterceptor.js";
import type { Token } from "./types/token.js";

export interface CatalystTSOptions {
  clientId: string;
  clientSecret: string;
  accessToken?: string;
  refreshToken?: string;
  interceptors?: RequestInterceptor[];
}

export class CatalystTS {
  readonly clientId: string;
  readonly clientSecret: string;

  private _accessToken: string | undefined;
  private _refreshToken: string | undefined;

  private readonly http: HttpClient;

  constructor(opts: CatalystTSOptions) {
    this.clientId = opts.clientId;
    this.clientSecret = opts.clientSecret;
    this._accessToken = opts.accessToken;
    this._refreshToken = opts.refreshToken;

    const interceptors: RequestInterceptor[] = [
      ...(opts.interceptors ?? []),
      new AuthInterceptor(() => Promise.resolve(this._accessToken)),
      new UserAgentInterceptor(),
    ];

    this.http = new HttpClient(interceptors);
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

    const token = await this.oauth.getAccessTokenByRefreshToken(this._refreshToken);
    this._accessToken = token.accessToken;
    this._refreshToken = token.refreshToken;
    return token;
  }

  get oauth(): OAuth {
    return new OAuth(this.clientId, this.clientSecret);
  }

  get catalyst(): CatalystClient {
    return new CatalystClient(this.http);
  }

  get egeria(): EgeriaClient {
    return new EgeriaClient(this.http);
  }

  get media(): MediaClient {
    return new MediaClient(this.http);
  }

  get steambird(): SteambirdClient {
    return new SteambirdClient(this.http);
  }
}
