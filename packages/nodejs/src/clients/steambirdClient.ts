import { SteambirdEndpoint } from "../endpoints/steambirdEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type { Notifications, NotificationUnreadCount } from "../types/notifications.js";

export const ISSUER_CATALYST_SYSTEM_MESSAGE = "natsuneko-laboratory:catalyst";
export const ISSUER_CATALYST_USER_MESSAGE = "natsuneko-laboratory:catalyst-message";
export const ISSUER_EGERIA_SYSTEM_MESSAGE = "natsuneko-laboratory:egeria";

export class SteambirdClient {
  readonly ISSUER_CATALYST_SYSTEM_MESSAGE = ISSUER_CATALYST_SYSTEM_MESSAGE;
  readonly ISSUER_CATALYST_USER_MESSAGE = ISSUER_CATALYST_USER_MESSAGE;
  readonly ISSUER_EGERIA_SYSTEM_MESSAGE = ISSUER_EGERIA_SYSTEM_MESSAGE;

  constructor(private readonly http: HttpClient) {}

  notifications(issuer: string, opts: { since?: string; until?: string } = {}): Promise<Notifications> {
    return this.http.request(SteambirdEndpoint.notifications(issuer, opts));
  }

  read(id: string): Promise<void> {
    return this.http.requestVoid(SteambirdEndpoint.read(id));
  }

  readAll(issuer?: string): Promise<void> {
    return this.http.requestVoid(SteambirdEndpoint.readAll(issuer));
  }

  unreads(issuers: string[] = []): Promise<NotificationUnreadCount> {
    return this.http.request(SteambirdEndpoint.unreads(issuers));
  }
}
