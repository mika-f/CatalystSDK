import type { HttpMethod } from "../types/httpMethod.js";

export interface Endpoint {
  readonly path: string;
  readonly method: HttpMethod;
  readonly headers?: Record<string, string>;
  readonly queryParameters?: Record<string, string>;
  readonly body?: unknown;
}
