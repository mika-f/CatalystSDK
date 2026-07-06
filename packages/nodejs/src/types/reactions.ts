export interface CatalystReaction {
  name: string;
  symbol: string;
  url: string;
  count: number;
  hasSelfReaction?: boolean;
  customReactionId?: string;
}

export interface CatalystReactions {
  reactions: Record<string, CatalystReaction>;
}

// GET /catalyst/v1/reactions が返す標準絵文字リアクション定義
export interface CatalystCustomReaction {
  id: string;
  name: string;
  symbol: string;
  url: string;
}

export type CatalystCustomReactionStatus =
  | "active"
  | "moderated"
  | "hidden"
  | "disabled";

export type CatalystCustomReactionVisibility = "private" | "followers" | "public";

export type SupporterTier =
  | "none"
  | "tier_0"
  | "tier_1"
  | "tier_2"
  | "tier_3"
  | "tier_4"
  | "tier_5";

// GET /catalyst/v1/custom-reactions, POST /catalyst/v1/custom-reactions,
// PATCH /catalyst/v1/custom-reactions/{id} の items に含まれるユーザー独自リアクション
export interface CatalystUserCustomReaction {
  id: string;
  shortcode: string;
  displayName: string;
  imageUrl: string;
  mimeType: string;
  sortOrder: number;
  status: CatalystCustomReactionStatus;
  visibility: CatalystCustomReactionVisibility;
  createdAt: string;
}

export interface CatalystCustomReactionList {
  plan: SupporterTier;
  limit: number;
  used: number;
  items: CatalystUserCustomReaction[];
}

export interface UpdateCustomReactionRequest {
  displayName?: string;
  sortOrder?: number;
}
