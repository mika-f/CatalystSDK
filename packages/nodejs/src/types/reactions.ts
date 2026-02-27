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

export interface CatalystCustomReaction {
  name: string;
  symbol: string;
  url: string;
}
