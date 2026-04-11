export interface ReportRequest {
  type: "nsfw" | "tos_violation" | "harassment" | "spam" | "other";
  description?: string;
}
