import type { EgeriaUser } from "./users.js";

export interface NotificationGroup {
  id: string;
  body: string;
  occurredBy: EgeriaUser;
  isRead: boolean;
}

export interface Notification {
  id: string;
  title: string;
  isGrouped: boolean;
  belongsTo: Record<string, unknown>;
  entities: NotificationGroup[];
  hasMore: boolean;
  read: boolean;
}

export interface Notifications {
  notifications: Notification[];
}

export interface NotificationUnreadCount {
  unread: number;
}
