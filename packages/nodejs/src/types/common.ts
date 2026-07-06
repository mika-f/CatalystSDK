// Generic response shapes shared across many Catalyst mutation/list endpoints.

/** Generic `{"result": boolean}` response shape used by many mutation endpoints. */
export interface CatalystResult {
  result: boolean;
}

/** Generic `{"value": number}` response shape used by reaction toggle endpoints. */
export interface CatalystReactionValue {
  value: number;
}

/** Generic `{"message": string}` response shape. */
export interface CatalystMessage {
  message: string;
}

/** Total/offset counters used by several list endpoints. */
export interface CountInfo {
  total: number;
  offset: number;
}

/** Page cursor metadata used by several list endpoints. */
export interface PageInfo {
  min: number;
  max: number;
  current: number;
  next: number | null;
  prev: number | null;
}
