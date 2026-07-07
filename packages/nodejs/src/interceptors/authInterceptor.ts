import type { Interceptor, RequestInterceptorFn } from "./interceptor.js";

export class AuthInterceptor implements Interceptor {
  constructor(
    private readonly tokenProvider: () => Promise<string | undefined>,
  ) {}

  onRequest: RequestInterceptorFn = async (request) => {
    const token = await this.tokenProvider();
    if (token == null) return request;

    request.headers.set("Authorization", `Bearer ${token}`);
    return request;
  };
}
