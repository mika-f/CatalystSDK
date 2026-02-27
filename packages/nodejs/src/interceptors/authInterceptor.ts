import type { RequestInterceptor } from "./requestInterceptor.js";
import { ApiError } from "../types/apiError.js";

export class AuthInterceptor implements RequestInterceptor {
  private readonly retryCounts = new Map<string, number>();
  private readonly maxRetryCount = 5;

  constructor(private readonly tokenProvider: () => Promise<string | undefined>) {}

  async adapt(request: Request): Promise<Request> {
    const token = await this.tokenProvider();
    if (token == null) return request;

    const headers = new Headers(request.headers);
    headers.set("Authorization", `Bearer ${token}`);
    return new Request(request, { headers });
  }

  async retry(request: Request, error: unknown): Promise<boolean> {
    if (!(error instanceof ApiError) || error.statusCode !== 401) return false;

    const key = this.makeRequestKey(request);
    const count = this.retryCounts.get(key) ?? 0;

    if (count >= this.maxRetryCount) {
      this.retryCounts.delete(key);
      return false;
    }

    this.retryCounts.set(key, count + 1);
    return true;
  }

  private makeRequestKey(request: Request): string {
    return `${request.method}:${request.url}`;
  }
}
