export interface Token {
  accessToken: string;
  refreshToken: string;
  tokenType: string;
  /** Present on responses from the real token-exchange endpoint (e.g. "read write"). */
  scope?: string;
  /** ISO8601 timestamp string for when the access token expires. */
  expiresAt?: string;
  /** Seconds until the access token expires. */
  expiresIn?: number;
}
