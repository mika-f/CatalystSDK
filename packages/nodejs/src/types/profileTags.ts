import type { EgeriaUser } from "./users.js";

export interface ProfileTag {
  id: string;
  name: string;
  normalizedName: string;
}

export interface ProfileTagSuggestion {
  id: string;
  name: string;
  usageCount: number;
}

export interface ProfileTagUser extends EgeriaUser {
  matchedTags: string[];
}

export interface UpdateProfileTagsRequest {
  tags: string[];
}
