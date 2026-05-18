export interface ReportRequest {
  reason: "nsfw" | "tos_violation" | "harassment" | "spam" | "other";
  description?: string;
}
