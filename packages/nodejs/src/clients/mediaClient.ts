import { MediaEndpoint } from "../endpoints/mediaEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type { MediaUploadUrls, MediaDownloadRequest } from "../types/media.js";

export class MediaClient {
  constructor(private readonly http: HttpClient) {}

  /** Gets a signed URL for uploading media (v1). */
  uploadV1(): Promise<MediaUploadUrls> {
    return this.http.request(MediaEndpoint.uploadV1());
  }

  /**
   * Downloads media by URL.
   *
   * Not documented in the current OpenAPI spec, but still supported by the live API.
   */
  download(data: MediaDownloadRequest): Promise<ArrayBuffer> {
    return this.http.requestRaw(MediaEndpoint.download(data));
  }

  /** Deletes media by URL. */
  delete(url: string): Promise<boolean> {
    return this.http.request(MediaEndpoint.delete({ url }));
  }

  /** Gets a signed URL for uploading media (v2). */
  upload(): Promise<MediaUploadUrls> {
    return this.http.request(MediaEndpoint.upload());
  }
}
