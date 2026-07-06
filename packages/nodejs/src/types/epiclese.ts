import type { EgeriaUser } from "./users.js";
import type { CountInfo, PageInfo } from "./common.js";

export interface EpiclesePlatform {
  id: string;
  name: string;
  description: string;
  url: string | null;
  startAt: string | null;
}

export interface EpiclesePlatformsWrapper {
  platforms: EpiclesePlatform[];
}

export interface EpiclesePlatformWrapper {
  platform: EpiclesePlatform;
}

export interface EpicleseAuthor {
  id: string;
  platformIdentifier: string;
  platform: EpiclesePlatform | null;
  name: string;
}

export interface EpicleseAuthorWrapper {
  author: EpicleseAuthor;
}

/** Paginated result of `GET /epiclese/v1/authors`. */
export interface EpicleseAuthorsResult {
  items: EpicleseAuthor[];
  count: CountInfo;
  page: PageInfo;
}

export interface EpicleseWorld {
  id: string;
  platformIdentifier: string;
  platform: EpiclesePlatform | null;
  name: string;
  author: EpicleseAuthor | null;
}

export interface EpicleseWorldWrapper {
  world: EpicleseWorld | null;
}

/** Internal wrapper for `GET /epiclese/v1/worlds` (`{"items": [...]}`, unwrapped by the client). */
export interface EpicleseWorldsWrapper {
  items: EpicleseWorld[];
}

export interface EpicleseCreateAuthorRequest {
  id?: string;
  platformIdentifier: string;
  platform: string;
  name: string;
}

export interface EpicleseCreateWorldRequest {
  id?: string;
  platformIdentifier: string;
  platform: string;
  name: string;
  author: EpicleseCreateAuthorRequest | null;
}

export interface EpicleseCreateStatusMetadataReferenceRequest {
  x: number;
  y: number;
  /** UUID referencing another tag entry within the same batch request. */
  reference?: string;
  type: string;
  name: string;
  description?: string;
  externalUrl?: string;
  author?: EpicleseCreateAuthorRequest;
}

export interface EpicleseCreateStatusMetadataTagRequest {
  id: string;
  platform?: string;
  world?: EpicleseCreateWorldRequest;
  users?: { id: string }[];
  reference: EpicleseCreateStatusMetadataReferenceRequest[];
  privacyMetadata?: boolean;
}

export interface EpicleseStatusMetadataReference {
  type: string;
  name: string;
  description: string;
  externalUrl: string | null;
  author: EpicleseAuthor;
  x: number;
  y: number;
  reference: string;
}

export interface EpicleseStatusMetadataTag {
  platform: string | null;
  world: EpicleseWorld | null;
  users: EgeriaUser[];
  reference: EpicleseStatusMetadataReference[];
  additionalData?: Record<string, string>;
  additionalData2?: Record<string, { value: string; ref: string | null }>;
}

/** `EpicleseStatusMetadataResponse` — a map keyed by tag id. */
export type EpicleseStatusMetadata = Record<string, EpicleseStatusMetadataTag>;
