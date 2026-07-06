/** A single month bucket in the status archive. */
export interface CatalystArchiveMonth {
  year: number;
  month: number;
  count: number;
}

/** Wrapper for the `{"months": [...]}` response shape. */
export interface CatalystArchiveMonths {
  months: CatalystArchiveMonth[];
}
