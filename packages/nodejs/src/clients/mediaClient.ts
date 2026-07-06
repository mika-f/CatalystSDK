import { MediaEndpoint } from "../endpoints/mediaEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type { MediaUploadUrls } from "../types/media.js";

export class MediaClient {
  constructor(private readonly http: HttpClient) {}

  /** Gets a signed URL for uploading media (v1). */
  uploadV1(): Promise<MediaUploadUrls> {
    return this.http.request(MediaEndpoint.uploadV1());
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
