import type { RequestInterceptor } from "./requestInterceptor.js";

export class UserAgentInterceptor implements RequestInterceptor {
  private readonly agent: string;

  constructor() {
    this.agent = "CatalystTS/0.1.0";
  }

  async adapt(request: Request): Promise<Request> {
    const headers = new Headers(request.headers);
    headers.set("User-Agent", this.agent);
    return new Request(request, { headers });
  }

  async retry(_request: Request, _error: unknown): Promise<boolean> {
    return false;
  }
}
