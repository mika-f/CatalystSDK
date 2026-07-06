import type { Endpoint } from "./endpoint.js";
import type { MediaDeleteRequest } from "../types/media.js";

export const MediaEndpoint = {
  /** Gets a signed URL for uploading media (v1). */
  uploadV1(): Endpoint {
    return { path: "/media/v1/upload", method: "POST" };
  },

  delete(data: MediaDeleteRequest): Endpoint {
    return { path: "/media/v1/upload", method: "DELETE", body: data };
  },

  /** Gets a signed URL for uploading media (v2). */
  upload(): Endpoint {
    return { path: "/media/v2/upload", method: "POST" };
  },
} as const;
