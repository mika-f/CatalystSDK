import type { EgeriaUser } from "./users.js";

export interface NotificationAdditionalContext {
  type: "custom-reaction";
  url: string;
  format: string;
}

export interface NotificationGroup {
  id: string;
  body: string;
  occurredBy: EgeriaUser;
  isRead: boolean;
  createdAt: string;
  additionalContexts?: NotificationAdditionalContext | null;
}

export interface Notification {
  id: string;
  title: string;
  isGrouped: boolean;
  belongsTo?: Record<string, unknown>;
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
