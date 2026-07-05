// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.clients

import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.*

/**
 * Client for Epiclese (World/Author metadata) API endpoints
 */
class EpicleseClient internal constructor(
    private val httpClient: CatalystHttpClient
) {
    suspend fun getAuthors(query: String? = null, platform: String? = null): EpicleseAuthorsResult = httpClient.get(
        "/epiclese/v1/authors",
        mapOf("q" to query, "platform" to platform)
    )

    suspend fun createAuthor(
        platformIdentifier: String,
        platform: String,
        name: String,
        id: String? = null
    ): EpicleseAuthor = httpClient.postWithResult<EpicleseAuthorWrapper>(
        "/epiclese/v1/authors",
        mapOf(
            "platformIdentifier" to platformIdentifier,
            "platform" to platform,
            "name" to name,
            "id" to id
        ).filterValues { it != null }
    ).author

    suspend fun getPlatforms(): List<EpiclesePlatform> =
        httpClient.get<EpiclesePlatformsWrapper>("/epiclese/v1/platforms").platforms

    suspend fun getPlatform(id: String): EpiclesePlatform =
        httpClient.get<EpiclesePlatformWrapper>("/epiclese/v1/platforms/$id").platform

    suspend fun getStatusMetadata(statusId: String): Map<String, EpicleseStatusMetadataTag> =
        httpClient.get("/epiclese/v1/tag/by/status/$statusId")

    suspend fun createStatusMetadata(
        statusId: String,
        tags: List<Map<String, Any?>>
    ): Map<String, EpicleseStatusMetadataTag> = httpClient.postWithResult(
        "/epiclese/v1/tag/by/status/$statusId",
        tags
    )

    suspend fun getWorlds(
        query: String? = null,
        platform: String? = null,
        offset: Int? = null
    ): List<EpicleseWorld> = httpClient.get<EpicleseWorldsResult>(
        "/epiclese/v1/worlds",
        mapOf("q" to query, "platform" to platform, "offset" to offset?.toString())
    ).items

    suspend fun createWorld(
        platformIdentifier: String,
        platform: String,
        name: String,
        author: Map<String, Any?>? = null,
        id: String? = null
    ): EpicleseWorld? = httpClient.postWithResult<EpicleseWorldWrapper>(
        "/epiclese/v1/worlds",
        mapOf(
            "platformIdentifier" to platformIdentifier,
            "platform" to platform,
            "name" to name,
            "author" to author,
            "id" to id
        ).filterValues { it != null }
    ).world

    suspend fun resolveWorld(platform: String, name: String): EpicleseWorld? = httpClient.get<EpicleseWorldWrapper>(
        "/epiclese/v1/worlds/resolve",
        mapOf("platform" to platform, "name" to name)
    ).world
}
