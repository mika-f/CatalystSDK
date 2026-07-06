import { EpicleseEndpoint } from "../endpoints/epicleseEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type {
  EpicleseAuthor,
  EpicleseAuthorWrapper,
  EpicleseAuthorsResult,
  EpiclesePlatform,
  EpiclesePlatformsWrapper,
  EpiclesePlatformWrapper,
  EpicleseWorld,
  EpicleseWorldWrapper,
  EpicleseWorldsWrapper,
  EpicleseCreateAuthorRequest,
  EpicleseCreateWorldRequest,
  EpicleseCreateStatusMetadataTagRequest,
  EpicleseStatusMetadata,
} from "../types/epiclese.js";

/** Client for Epiclese (world/author metadata) API endpoints. */
export class EpicleseClient {
  constructor(private readonly http: HttpClient) {}

  getAuthors(q?: string, platform?: string): Promise<EpicleseAuthorsResult> {
    return this.http.request(EpicleseEndpoint.getAuthors(q, platform));
  }

  async createAuthor(data: EpicleseCreateAuthorRequest): Promise<EpicleseAuthor> {
    const response = await this.http.request<EpicleseAuthorWrapper>(
      EpicleseEndpoint.createAuthor(data),
    );
    return response.author;
  }

  async getPlatforms(): Promise<EpiclesePlatform[]> {
    const response = await this.http.request<EpiclesePlatformsWrapper>(
      EpicleseEndpoint.getPlatforms(),
    );
    return response.platforms;
  }

  async getPlatform(id: string): Promise<EpiclesePlatform> {
    const response = await this.http.request<EpiclesePlatformWrapper>(
      EpicleseEndpoint.getPlatform(id),
    );
    return response.platform;
  }

  getStatusMetadata(statusId: string): Promise<EpicleseStatusMetadata> {
    return this.http.request(EpicleseEndpoint.getStatusMetadata(statusId));
  }

  createStatusMetadata(
    statusId: string,
    tags: EpicleseCreateStatusMetadataTagRequest[],
  ): Promise<EpicleseStatusMetadata> {
    return this.http.request(
      EpicleseEndpoint.createStatusMetadata(statusId, tags),
    );
  }

  async getWorlds(q?: string, platform?: string, offset?: number): Promise<EpicleseWorld[]> {
    const response = await this.http.request<EpicleseWorldsWrapper>(
      EpicleseEndpoint.getWorlds(q, platform, offset),
    );
    return response.items;
  }

  async createWorld(data: EpicleseCreateWorldRequest): Promise<EpicleseWorld | null> {
    const response = await this.http.request<EpicleseWorldWrapper>(
      EpicleseEndpoint.createWorld(data),
    );
    return response.world;
  }

  async resolveWorld(platform: string, name: string): Promise<EpicleseWorld | null> {
    const response = await this.http.request<EpicleseWorldWrapper>(
      EpicleseEndpoint.resolveWorld(platform, name),
    );
    return response.world;
  }
}
