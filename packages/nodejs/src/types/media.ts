export interface MediaMetadata {
  width?: number;
  height?: number;
  isSensitive: boolean;
  isSpoiler: boolean;
}

export interface Media {
  id: string;
  alt: string;
  url: string;
  metadata?: MediaMetadata;
  privacyMetadata?: boolean;
}

export interface MediaUploadUrls {
  url: string;
  signedUrl: string;
}

export interface CatalystMediaWithMetadata {
  url: string;
  alt: string;
  width: number;
  height: number;
  bytes: number;
}

export interface MediaDeleteRequest {
  url: string;
}

export interface MediaDownloadRequest {
  url: string;
}
