import type { Endpoint } from "./endpoint.js";
import type { MediaDeleteRequest, MediaDownloadRequest } from "../types/media.js";

export const MediaEndpoint = {
  /** Gets a signed URL for uploading media (v1). */
  uploadV1(): Endpoint {
    return { path: "/media/v1/upload", method: "POST" };
  },

  /** Not documented in the current OpenAPI spec, but still supported by the live API. */
  download(data: MediaDownloadRequest): Endpoint {
    return { path: "/media/v1/download", method: "POST", body: data };
  },

  delete(data: MediaDeleteRequest): Endpoint {
    return { path: "/media/v1/upload", method: "DELETE", body: data };
  },

  /** Gets a signed URL for uploading media (v2). */
  upload(): Endpoint {
    return { path: "/media/v2/upload", method: "POST" };
  },
} as const;
