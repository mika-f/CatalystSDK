// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.clients

import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.*

/**
 * Client for Catalyst API endpoints
 */
class CatalystClient internal constructor(
    private val httpClient: CatalystHttpClient
) {
    // Album operations
    suspend fun createAlbum(
        name: String,
        description: String,
        isPublic: Boolean,
        mode: CatalystAlbumDisplayMode
    ): Identity = httpClient.postWithResult(
        "/catalyst/v1/album",
        mapOf(
            "name" to name,
            "description" to description,
            "isPublic" to isPublic,
            "mode" to mode
        )
    )

    suspend fun getAlbum(
        id: String,
        since: String? = null,
        until: String? = null
    ): CatalystAlbum = httpClient.get(
        "/catalyst/v1/album/by/id/$id",
        mapOf("since" to since, "until" to until)
    )

    suspend fun editAlbum(
        id: String,
        name: String? = null,
        description: String? = null,
        isPublic: Boolean? = null,
        mode: CatalystAlbumDisplayMode? = null
    ) = httpClient.patch(
        "/catalyst/v1/album/by/id/$id",
        mapOf(
            "name" to name,
            "description" to description,
            "isPublic" to isPublic,
            "mode" to mode
        ).filterValues { it != null }
    )

    suspend fun insertToAlbum(id: String, statusIds: List<String>) = httpClient.put(
        "/catalyst/v1/album/by/id/$id",
        mapOf("statusIds" to statusIds)
    )

    suspend fun removeFromAlbum(id: String, statusIds: List<String>) = httpClient.put(
        "/catalyst/v1/album/by/id/$id",
        mapOf("statusIds" to statusIds)
    )

    suspend fun deleteAlbum(id: String) = httpClient.delete("/catalyst/v1/album/by/id/$id")

    suspend fun listAlbums(
        username: String,
        includeSmartAlbums: Boolean = true
    ): List<CatalystSmartAlbum> = httpClient.get(
        "/catalyst/v1/album/by/user/$username",
        mapOf("include_smart_albums" to includeSmartAlbums.toString())
    )

    suspend fun searchAlbums(
        query: String,
        includeSmartAlbums: Boolean = true
    ): List<CatalystSmartAlbum> = httpClient.get(
        "/catalyst/v1/album/search",
        mapOf("q" to query, "include_smart_album" to includeSmartAlbums.toString())
    )

    // Smart Album operations
    suspend fun createSmartAlbum(
        name: String,
        description: String,
        isAllowNsfw: Boolean,
        isAllowOthers: Boolean,
        hashtags: List<String>,
        since: String? = null,
        until: String? = null,
        isPublic: Boolean,
        mode: CatalystAlbumDisplayMode
    ): Identity = httpClient.postWithResult(
        "/catalyst/v1/smart-album",
        mapOf(
            "name" to name,
            "description" to description,
            "isAllowNsfw" to isAllowNsfw,
            "isAllowOthers" to isAllowOthers,
            "hashtags" to hashtags,
            "since" to since,
            "until" to until,
            "isPublic" to isPublic,
            "mode" to mode
        ).filterValues { it != null }
    )

    suspend fun getSmartAlbum(
        id: String,
        since: String? = null,
        until: String? = null
    ): CatalystSmartAlbum = httpClient.get(
        "/catalyst/v1/smart-album/by/id/$id",
        mapOf("since" to since, "until" to until)
    )

    suspend fun editSmartAlbum(
        id: String,
        name: String? = null,
        description: String? = null,
        isAllowNsfw: Boolean? = null,
        isAllowOthers: Boolean? = null,
        hashtags: List<String>? = null,
        since: String? = null,
        until: String? = null,
        isPublic: Boolean? = null,
        mode: CatalystAlbumDisplayMode? = null
    ) = httpClient.patch(
        "/catalyst/v1/smart-album/by/id/$id",
        mapOf(
            "name" to name,
            "description" to description,
            "isAllowNsfw" to isAllowNsfw,
            "isAllowOthers" to isAllowOthers,
            "hashtags" to hashtags,
            "since" to since,
            "until" to until,
            "isPublic" to isPublic,
            "mode" to mode
        ).filterValues { it != null }
    )

    suspend fun deleteSmartAlbum(id: String) = httpClient.delete("/catalyst/v1/smart-album/by/id/$id")

    suspend fun searchSmartAlbums(query: String): List<CatalystSmartAlbum> = httpClient.get(
        "/catalyst/v1/smart-album/search",
        mapOf("q" to query)
    )

    // Reactions
    suspend fun getCustomReactions(): List<CatalystCustomReaction> = httpClient.get("/catalyst/v1/reactions")

    // Relationships
    suspend fun getRelationships(userId: String): CatalystRelationships = httpClient.get("/catalyst/v1/relationships/$userId")

    suspend fun follow(userId: String) = httpClient.post(
        "/catalyst/v1/relationships",
        mapOf("userId" to userId)
    )

    suspend fun remove(userId: String) = httpClient.delete(
        "/catalyst/v1/relationships",
        mapOf("userId" to userId)
    )

    // Status operations
    suspend fun createStatus(
        body: String,
        privacy: CatalystStatusPrivacy,
        mediaIds: List<String> = emptyList()
    ): Identity = httpClient.postWithResult(
        "/catalyst/v1/status",
        mapOf(
            "body" to body,
            "privacy" to privacy,
            "mediaIds" to mediaIds
        )
    )

    suspend fun getStatus(id: String): CatalystStatus = httpClient.get("/catalyst/v1.1/status/$id")

    suspend fun editStatus(
        id: String,
        body: String? = null,
        privacy: CatalystStatusPrivacy? = null,
        mediaIds: List<String>? = null
    ) = httpClient.patch(
        "/catalyst/v1/status/$id",
        mapOf(
            "body" to body,
            "privacy" to privacy,
            "mediaIds" to mediaIds
        ).filterValues { it != null }
    )

    suspend fun deleteStatus(id: String) = httpClient.delete("/catalyst/v1/status/$id")

    suspend fun isFavorited(id: String): Boolean = httpClient.get("/catalyst/v1/status/$id/favorite")

    suspend fun favorite(id: String) = httpClient.post("/catalyst/v1/status/$id/favorite")

    suspend fun unfavorite(id: String) = httpClient.delete("/catalyst/v1/status/$id/favorite")

    suspend fun getReactions(id: String): List<CatalystReaction> = httpClient.get("/catalyst/v1/status/$id/reactions")

    suspend fun react(id: String, symbol: String) = httpClient.post("/catalyst/v1/status/$id/reactions/$symbol")

    suspend fun unreact(id: String, symbol: String) = httpClient.delete("/catalyst/v1/status/$id/reactions/$symbol")

    // Timelines
    suspend fun getContestTimeline(
        slug: String,
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get(
        "/catalyst/v1/timeline/contest/by/slug/$slug",
        mapOf("since" to since, "until" to until)
    )

    suspend fun getFavoriteTimeline(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get(
        "/catalyst/v1/timeline/favorite",
        mapOf("since" to since, "until" to until)
    )

    suspend fun getFirehoseTimeline(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get(
        "/catalyst/v1.1/timeline/firehose",
        mapOf("since" to since, "until" to until)
    )

    suspend fun getGalleryTimeline(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get(
        "/catalyst/v1/timeline/gallery",
        mapOf("since" to since, "until" to until)
    )

    suspend fun getHomeTimeline(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get(
        "/catalyst/v1.1/timeline/home",
        mapOf("since" to since, "until" to until)
    )

    suspend fun searchTimeline(
        query: String,
        exact: Boolean = false,
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get(
        "/catalyst/v1/timeline/search",
        mapOf(
            "q" to query,
            "exact" to exact.toString(),
            "since" to since,
            "until" to until
        )
    )

    suspend fun getUserTimeline(
        username: String,
        trimUser: Boolean = false,
        excludeSensitive: Boolean = true,
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get(
        "/catalyst/v1/timeline/user/by/username/$username",
        mapOf(
            "trim_user" to trimUser.toString(),
            "exclude_sensitive" to excludeSensitive.toString(),
            "since" to since,
            "until" to until
        )
    )

    suspend fun getUserGalleryTimeline(
        username: String,
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get(
        "/catalyst/v1/timeline/user/by/username/$username/gallery",
        mapOf("since" to since, "until" to until)
    )

    // Trends
    suspend fun getTrends(): List<String> = httpClient.get("/catalyst/v1/trend")
}
