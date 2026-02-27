import { EgeriaEndpoint } from "../endpoints/egeriaEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type { EgeriaUserWrapper, EgeriaUsers, EgeriaUpdateProfileRequest } from "../types/users.js";

export class EgeriaClient {
  constructor(private readonly http: HttpClient) {}

  me(): Promise<EgeriaUserWrapper | undefined> {
    return this.http.request<EgeriaUserWrapper | undefined>(EgeriaEndpoint.me());
  }

  update(data: EgeriaUpdateProfileRequest): Promise<void> {
    return this.http.requestVoid(EgeriaEndpoint.update(data));
  }

  search(q: string): Promise<EgeriaUsers> {
    return this.http.request(EgeriaEndpoint.search(q));
  }

  userById(id: string): Promise<EgeriaUserWrapper | undefined> {
    return this.http.request<EgeriaUserWrapper | undefined>(EgeriaEndpoint.userById(id));
  }

  userByUsername(username: string): Promise<EgeriaUserWrapper | undefined> {
    return this.http.request<EgeriaUserWrapper | undefined>(EgeriaEndpoint.userByUsername(username));
  }
}
