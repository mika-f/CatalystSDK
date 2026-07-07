import type { Interceptor, RequestInterceptorFn } from "./interceptor.js";

export class UserAgentInterceptor implements Interceptor {
  private readonly agent: string;

  constructor() {
    this.agent = "CatalystTS/1.0.0-alpha.4";
  }

  onRequest: RequestInterceptorFn = async (request) => {
    request.headers.set("User-Agent", this.agent);
    return request;
  };
}
