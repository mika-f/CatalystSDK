export interface EgeriaUserProfile {
  iconUrl: string;
  bannerUrl: string;
  bio: string;
  website: string;
  additionalWebsites: string[];
}

/** The `profileEmoji` shown alongside a "standard" (unicode) emoji value. */
export interface ProfileEmojiStandard {
  type: "standard";
  value: string;
  imageUrl: string;
}

/** The `profileEmoji` shown when the user selected one of their custom reactions. */
export interface ProfileEmojiCustom {
  type: "custom";
  id: string;
  shortcode: string;
  displayName: string;
  imageUrl: string;
  width: number;
  height: number;
}

/** Discriminated union (on `type`) modeling the response's `profileEmoji` field. */
export type ProfileEmoji = ProfileEmojiStandard | ProfileEmojiCustom;

/** Request-shaped `profileEmoji` variant for `PATCH /egeria/v1/me` (fewer fields than the response). */
export interface ProfileEmojiStandardRequest {
  type: "standard";
  value: string;
}

/** Request-shaped `profileEmoji` variant referencing an existing custom reaction by id. */
export interface ProfileEmojiCustomRequest {
  type: "custom";
  customReactionId: string;
}

export type ProfileEmojiRequest = ProfileEmojiStandardRequest | ProfileEmojiCustomRequest;

export interface EgeriaUser {
  id: string;
  screenName: string;
  displayName: string;
  profile?: EgeriaUserProfile | null;
  profileEmoji?: ProfileEmoji | null;
}

export interface EgeriaUserWrapper {
  user: EgeriaUser;
}

export interface EgeriaUsers {
  users: EgeriaUser[];
}

export interface EgeriaUpdateProfileRequest {
  screenName?: string;
  displayName?: string;
  profile?: EgeriaUserProfile;
  profileEmoji?: ProfileEmojiRequest | null;
}
