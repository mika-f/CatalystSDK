import type { RequestInterceptor } from "./requestInterceptor.js";

export class LoggingInterceptor implements RequestInterceptor {
  async adapt(request: Request): Promise<Request> {
    console.log(`[CatalystTS] ${request.method} ${request.url}`);
    return request;
  }

  async retry(request: Request, error: unknown): Promise<boolean> {
    console.log(`[CatalystTS] Retry ${request.method} ${request.url}`, error);
    return false;
  }
}
