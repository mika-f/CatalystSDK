/** A single entry in the "rich" trending list (`GET /catalyst/v1/trend?format=rich`). */
export interface CatalystRichTrendingItem {
  tag: string;
  rank: number;
  previousRank: number | null;
  movement: "up" | "down" | "same" | "new";
}
