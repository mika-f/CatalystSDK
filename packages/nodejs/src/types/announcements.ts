export interface CatalystAnnouncement {
  id: string;
  title: string;
  body: string;
  category: string;
  since: string;
  until: string;
  url: string | null;
}

/** Wrapper for the `{"announcements": [...]}` response shape. */
export interface CatalystAnnouncementsWrapper {
  announcements: CatalystAnnouncement[];
}
