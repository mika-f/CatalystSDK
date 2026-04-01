import { ApiError } from "../types/apiError.js";
import { PUBLIC_API_ENDPOINT } from "../types/constants.js";
import type { Endpoint } from "../endpoints/endpoint.js";
import type { RequestInterceptor } from "../interceptors/requestInterceptor.js";

export class HttpClient {
  constructor(private readonly interceptors: RequestInterceptor[] = []) {}

  private buildRequest(endpoint: Endpoint): Request {
    const url = new URL(endpoint.path, PUBLIC_API_ENDPOINT);

    if (endpoint.queryParameters != null) {
      for (const [key, value] of Object.entries(endpoint.queryParameters)) {
        url.searchParams.set(key, value);
      }
    }

    const headers = new Headers(endpoint.headers);

    let body: string | undefined;
    if (endpoint.body != null) {
      body = JSON.stringify(endpoint.body);
      headers.set("Content-Type", "application/json");
    }

    return new Request(url.toString(), {
      method: endpoint.method,
      headers,
      body,
    });
  }

  async request<T>(endpoint: Endpoint): Promise<T> {
    let req = this.buildRequest(endpoint);

    for (const interceptor of this.interceptors) {
      req = await interceptor.adapt(req);
    }

    const response = await this.executeWithRetry(req, endpoint);

    const text = await response.text();
    if (!text) throw new Error("Empty response body");

    try {
      return JSON.parse(text) as T;
    } catch (cause) {
      throw ApiError.decodingError(cause);
    }
  }

  async requestVoid(endpoint: Endpoint): Promise<void> {
    let req = this.buildRequest(endpoint);

    for (const interceptor of this.interceptors) {
      req = await interceptor.adapt(req);
    }

    await this.executeWithRetry(req, endpoint);
  }

  async requestRaw(endpoint: Endpoint): Promise<ArrayBuffer> {
    let req = this.buildRequest(endpoint);

    for (const interceptor of this.interceptors) {
      req = await interceptor.adapt(req);
    }

    const response = await this.executeWithRetry(req, endpoint);
    return response.arrayBuffer();
  }

  private async executeWithRetry(req: Request, endpoint: Endpoint): Promise<Response> {
    const response = await fetch(req);

    if (!response.ok) {
      const error = ApiError.httpError(response.status);

      for (const interceptor of this.interceptors) {
        const shouldRetry = await interceptor.retry(req, error);
        if (shouldRetry) {
          // Rebuild and re-adapt request so interceptors (e.g. auth) pick up refreshed tokens
          let retryReq = this.buildRequest(endpoint);
          for (const adaptInterceptor of this.interceptors) {
            retryReq = await adaptInterceptor.adapt(retryReq);
          }
          return this.executeWithRetry(retryReq, endpoint);
        }
      }

      throw error;
    }

    return response;
  }
}
