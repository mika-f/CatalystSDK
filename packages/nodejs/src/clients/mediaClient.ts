import { MediaEndpoint } from "../endpoints/mediaEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type { MediaUploadUrls, MediaDeleteRequest, MediaDownloadRequest } from "../types/media.js";

export class MediaClient {
  constructor(private readonly http: HttpClient) {}

  download(data: MediaDownloadRequest): Promise<ArrayBuffer> {
    return this.http.requestRaw(MediaEndpoint.download(data));
  }

  delete(data: MediaDeleteRequest): Promise<void> {
    return this.http.requestVoid(MediaEndpoint.delete(data));
  }

  upload(): Promise<MediaUploadUrls> {
    return this.http.request(MediaEndpoint.upload());
  }
}
