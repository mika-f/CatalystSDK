import { SteambirdEndpoint } from "../endpoints/steambirdEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type { Notification, Notifications, NotificationUnreadCount } from "../types/notifications.js";
import type { CatalystResult } from "../types/common.js";

export const ISSUER_CATALYST_SYSTEM_MESSAGE = "natsuneko-laboratory:catalyst";
export const ISSUER_CATALYST_USER_MESSAGE = "natsuneko-laboratory:catalyst-message";
export const ISSUER_EGERIA_SYSTEM_MESSAGE = "natsuneko-laboratory:egeria";

export class SteambirdClient {
  readonly ISSUER_CATALYST_SYSTEM_MESSAGE = ISSUER_CATALYST_SYSTEM_MESSAGE;
  readonly ISSUER_CATALYST_USER_MESSAGE = ISSUER_CATALYST_USER_MESSAGE;
  readonly ISSUER_EGERIA_SYSTEM_MESSAGE = ISSUER_EGERIA_SYSTEM_MESSAGE;

  constructor(private readonly http: HttpClient) {}

  /** Gets notifications for a specific issuer, or all issuers if omitted. */
  async notifications(
    issuer?: string,
    opts: { since?: string; until?: string } = {},
  ): Promise<Notification[]> {
    const response = await this.http.request<Notifications>(
      SteambirdEndpoint.notifications(issuer, opts),
    );
    return response.notifications;
  }

  read(id: string): Promise<CatalystResult> {
    return this.http.request(SteambirdEndpoint.read(id));
  }

  readAll(issuer?: string): Promise<CatalystResult> {
    return this.http.request(SteambirdEndpoint.readAll(issuer));
  }

  unreads(issuer?: string, issuers: string[] = []): Promise<NotificationUnreadCount> {
    return this.http.request(SteambirdEndpoint.unreads(issuer, issuers));
  }
}
