import type { EgeriaUser } from "./users.js";
import type { CatalystStatus } from "./status.js";

export type CatalystAlbumDisplayMode = "timeline" | "grid" | "gallery";

export interface CatalystAlbum {
  id: string;
  name: string;
  description: string;
  isPublic: boolean;
  mode: CatalystAlbumDisplayMode;
  user: EgeriaUser;
  statuses: CatalystStatus[];
}

export interface CatalystSmartAlbum {
  id: string;
  name: string;
  description: string;
  isAllowNsfw: boolean;
  isAllowOthers: boolean;
  since?: string;
  until?: string;
  isPublic: boolean;
  mode: CatalystAlbumDisplayMode;
  user?: EgeriaUser;
  type?: string;
  statuses: CatalystStatus[];
  hashtags: string[];
}

export interface CatalystSmartAlbums {
  albums: CatalystSmartAlbum[];
}

export interface CatalystCreateAlbumRequest {
  title: string;
  description: string;
  isPublic: boolean;
  mode: CatalystAlbumDisplayMode;
}

export interface CatalystEditAlbumRequest {
  title: string;
  description: string;
  isPublic: boolean;
  mode: CatalystAlbumDisplayMode;
}

export interface CatalystInsertToAlbumRequest {
  insert: string;
}

export interface CatalystRemoveFromAlbumRequest {
  remove: string;
}

export interface CatalystCreateSmartAlbumRequest {
  title: string;
  description: string;
  hashtags: string[];
  since?: string;
  until?: string;
  isAllowNsfw?: boolean;
  isAllowOthers?: boolean;
  isPublic: boolean;
  mode?: CatalystAlbumDisplayMode;
}

export interface CatalystEditSmartAlbumRequest {
  title: string;
  description: string;
  hashtags: string[];
  since?: string;
  until?: string;
  isAllowNsfw?: boolean;
  isAllowOthers?: boolean;
  isPublic: boolean;
  mode?: CatalystAlbumDisplayMode;
}
