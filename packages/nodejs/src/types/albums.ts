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

/** Wrapper for the `{"albums": [...]}` response shape, e.g. `GET /catalyst/v1/status/{id}/albums`. */
export interface CatalystAlbumsWrapper {
  albums: CatalystAlbum[];
}

export interface CatalystSmartAlbum {
  id: string;
  name: string;
  description: string;
  isAllowNsfw: boolean;
  isAllowOthers: boolean;
  since?: string | null;
  until?: string | null;
  isPublic: boolean;
  mode: CatalystAlbumDisplayMode;
  user: EgeriaUser | null;
  statuses: CatalystStatus[];
  hashtags: string[];
}

export interface CatalystSmartAlbums {
  albums: CatalystSmartAlbum[];
}

/** A "type"-discriminated album, returned by album-by-me/by-user/search endpoints which mix
 * plain albums and smart albums in the same list (`AlbumOrSmartAlbumResponse`). */
export interface CatalystAlbumOrSmartAlbum {
  id: string;
  name: string;
  description: string;
  hashtags: string[];
  isAllowNsfw: boolean;
  isAllowOthers: boolean;
  isPublic: boolean;
  since: string | null;
  until: string | null;
  mode: CatalystAlbumDisplayMode;
  user: EgeriaUser;
  statuses: CatalystStatus[];
  type: "album" | "smart-album";
}

export interface CatalystAlbumOrSmartAlbums {
  albums: CatalystAlbumOrSmartAlbum[];
}

export interface CatalystCreateAlbumRequest {
  title: string;
  description?: string;
  isPublic?: boolean;
  mode?: CatalystAlbumDisplayMode;
}

export interface CatalystEditAlbumRequest {
  title: string;
  description?: string;
  isPublic?: boolean;
  mode?: CatalystAlbumDisplayMode;
}

/** Shared request body for `PUT /catalyst/v1/album/by/id/{id}` (both insert and remove). */
export interface CatalystInsertOrRemoveStatusAlbumRequest {
  insert?: string;
  remove?: string;
}

/** @deprecated use {@link CatalystInsertOrRemoveStatusAlbumRequest} */
export interface CatalystInsertToAlbumRequest {
  insert: string;
}

/** @deprecated use {@link CatalystInsertOrRemoveStatusAlbumRequest} */
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
  isPublic?: boolean;
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
  isPublic?: boolean;
  mode?: CatalystAlbumDisplayMode;
}

export type CatalystAlbumBookTemplate = "photo-book" | "record-book";
export type CatalystAlbumBookQuality = "web" | "print";
export type CatalystAlbumBookTocType = "per-post" | "page-only";
export type CatalystAlbumBookStatus = "pending" | "processing" | "completed" | "failed";

/** `AlbumBookResponse` — a generated photo/record book for an album or smart album. */
export interface CatalystAlbumBook {
  id: string;
  albumId: string | null;
  smartAlbumId: string | null;
  template: CatalystAlbumBookTemplate;
  quality: CatalystAlbumBookQuality;
  coverImageUrl: string | null;
  subtitle: string | null;
  customText: string | null;
  showBody: boolean;
  showDate: boolean;
  showUrl: boolean;
  tocType: CatalystAlbumBookTocType | null;
  colophonText: string | null;
  status: CatalystAlbumBookStatus;
  errorMessage: string | null;
  downloadUrl: string | null;
  expiresAt: string | null;
  createdAt: string | null;
  updatedAt: string | null;
}

/** Request body for `POST /catalyst/v1/{album,smart-album}/by/id/{id}/book` (`CreateAlbumBook`). */
export interface CatalystCreateAlbumBookRequest {
  template: CatalystAlbumBookTemplate;
  quality: CatalystAlbumBookQuality;
  coverImageUrl?: string;
  subtitle?: string;
  customText?: string;
  showBody?: boolean;
  showDate?: boolean;
  showUrl?: boolean;
  showQrCode?: boolean;
  tocType?: CatalystAlbumBookTocType;
  colophonText?: string;
}
