export interface MediaMetadata {
  width: number | null;
  height: number | null;
  isSensitive: boolean;
  isSpoiler: boolean;
}

export interface Media {
  id: string;
  alt: string;
  url: string;
  order: number;
  metadata: MediaMetadata | null;
  privacyMetadata?: boolean;
  blurhash?: string | null;
}

export interface MediaUploadUrls {
  url: string;
  signedUrl: string;
}

export interface CatalystMediaWithMetadata {
  url: string;
  alt?: string;
  width: number;
  height: number;
  bytes: number;
}

export interface MediaDeleteRequest {
  url: string;
}

// Not documented in the current OpenAPI spec, but still supported by the live API.
export interface MediaDownloadRequest {
  url: string;
}
