import type { ResolvedRequestOptions } from "../generated/client/index.js";

export type RequestInterceptorFn = (
  request: Request,
  options: ResolvedRequestOptions,
) => Request | Promise<Request>;

export type ResponseInterceptorFn = (
  response: Response,
  request: Request,
  options: ResolvedRequestOptions,
) => Response | Promise<Response>;

export type ErrorInterceptorFn = (
  error: unknown,
  response: Response | undefined,
  request: Request | undefined,
  options: ResolvedRequestOptions,
) => unknown;

export interface Interceptor {
  onRequest?: RequestInterceptorFn;
  onResponse?: ResponseInterceptorFn;
  onError?: ErrorInterceptorFn;
}
