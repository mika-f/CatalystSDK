import type { EgeriaUser } from "./users.js";

export interface ProfileTag {
  id: string;
  name: string;
  normalizedName: string;
}

/** Wrapper for the `{"tags": [...]}` response shape. */
export interface ProfileTagsWrapper {
  tags: ProfileTag[];
}

export interface ProfileTagSuggestion {
  id: string;
  name: string;
  usageCount: number;
}

/** Wrapper for the `{"tags": [...]}` response shape (profile tag suggestions). */
export interface ProfileTagSuggestionsWrapper {
  tags: ProfileTagSuggestion[];
}

export interface ProfileTagUser extends EgeriaUser {
  matchedTags: string[];
}

/** Summary information for a profile tag (used within {@link ProfileTagUsersResult}). */
export interface ProfileTagSummary {
  name: string;
  usageCount: number;
}

/** Result of listing users by profile tag, including cursor-based pagination. */
export interface ProfileTagUsersResult {
  tag: ProfileTagSummary;
  users: ProfileTagUser[];
  nextCursor: string | null;
}

export interface UpdateProfileTagsRequest {
  tags: string[];
}
