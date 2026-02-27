import type { Endpoint } from "./endpoint.js";
import type { MediaDeleteRequest, MediaDownloadRequest } from "../types/media.js";

export const MediaEndpoint = {
  download(data: MediaDownloadRequest): Endpoint {
    return { path: "/media/v1/download", method: "POST", body: data };
  },

  delete(data: MediaDeleteRequest): Endpoint {
    return { path: "/media/v1/upload", method: "DELETE", body: data };
  },

  upload(): Endpoint {
    return { path: "/media/v2/upload", method: "POST" };
  },
} as const;
