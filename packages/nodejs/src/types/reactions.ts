export interface CatalystReaction {
  name: string;
  symbol: string;
  url: string;
  count: number;
  hasSelfReaction?: boolean;
}

export interface CatalystReactions {
  reactions: Record<string, CatalystReaction>;
}

export type CatalystCustomReactionStatus =
  | "active"
  | "moderated"
  | "hidden"
  | "disabled";

export type SupporterTier =
  | "none"
  | "tier_0"
  | "tier_1"
  | "tier_2"
  | "tier_3"
  | "tier_4"
  | "tier_5";

export interface CatalystCustomReaction {
  id: string;
  shortcode: string;
  displayName: string;
  imageUrl: string;
  mimeType: string;
  sortOrder: number;
  status: CatalystCustomReactionStatus;
  createdAt: string;
}

export interface CatalystCustomReactionList {
  plan: SupporterTier;
  limit: number;
  used: number;
  items: CatalystCustomReaction[];
}

export interface CreateCustomReactionRequest {
  shortcode: string;
  displayName: string;
}

export interface UpdateCustomReactionRequest {
  displayName?: string;
  sortOrder?: number;
}
