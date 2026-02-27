export class ApiError extends Error {
  constructor(
    message: string,
    public readonly statusCode?: number,
    public readonly cause?: unknown,
  ) {
    super(message);
    this.name = "ApiError";
  }

  static invalid(): ApiError {
    return new ApiError("Invalid response");
  }

  static httpError(statusCode: number): ApiError {
    return new ApiError(`HTTP Error: ${statusCode}`, statusCode);
  }

  static decodingError(cause: unknown): ApiError {
    return new ApiError("Decoding error", undefined, cause);
  }

  static unauthorized(): ApiError {
    return new ApiError("Unauthorized", 401);
  }
}

export class CatalystError extends Error {
  constructor(
    message: string,
    public readonly code?: number,
  ) {
    super(message);
    this.name = "CatalystError";
  }
}
