export interface EgeriaUserProfile {
  iconUrl: string;
  bannerUrl: string;
  bio: string;
  website: string;
  additionalWebsites: string[];
}

export interface EgeriaUser {
  id: string;
  screenName: string;
  displayName: string;
  profile?: EgeriaUserProfile;
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
}
