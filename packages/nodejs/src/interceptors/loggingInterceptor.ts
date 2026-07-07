import type {
  ErrorInterceptorFn,
  Interceptor,
  RequestInterceptorFn,
  ResponseInterceptorFn,
} from "./interceptor.js";

export class LoggingInterceptor implements Interceptor {
  onRequest: RequestInterceptorFn = async (request) => {
    console.log(`[CatalystTS] ${request.method} ${request.url}`);
    return request;
  };

  onResponse: ResponseInterceptorFn = async (response, request) => {
    console.log(
      `[CatalystTS] ${response.status} ${request.method} ${request.url}`,
    );
    return response;
  };

  onError: ErrorInterceptorFn = (error, _response, request) => {
    console.log(
      `[CatalystTS] Error ${request?.method ?? ""} ${request?.url ?? ""}`,
      error,
    );
    return error;
  };
}
