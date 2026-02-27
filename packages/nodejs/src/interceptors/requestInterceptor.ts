export interface RequestInterceptor {
  adapt(request: Request): Promise<Request>;
  retry(request: Request, error: unknown): Promise<boolean>;
}
