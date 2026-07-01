// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.clients

import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.*
import io.ktor.http.*

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

    suspend fun getCustomUserReactions(): CatalystCustomReactionList = httpClient.get("/catalyst/v1/custom-reactions")

    suspend fun createCustomReaction(
        shortcode: String,
        displayName: String,
        image: ByteArray,
        imageMimeType: String = "image/png"
    ): CatalystUserCustomReaction = httpClient.postMultipartWithResult("/catalyst/v1/custom-reactions") {
        append("shortcode", shortcode)
        append("displayName", displayName)
        append(
            "image",
            image,
            Headers.build {
                append(HttpHeaders.ContentType, imageMimeType)
                append(HttpHeaders.ContentDisposition, "filename=\"reaction.${if (imageMimeType == "image/jpeg") "jpg" else "png"}\"")
            }
        )
    }

    suspend fun updateCustomReaction(id: String, displayName: String? = null, sortOrder: Int? = null) =
        httpClient.patch(
            "/catalyst/v1/custom-reactions/$id",
            buildMap {
                displayName?.let { put("displayName", it) }
                sortOrder?.let { put("sortOrder", it) }
            }
        )

    suspend fun deleteCustomReaction(id: String) = httpClient.delete("/catalyst/v1/custom-reactions/$id")

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

    suspend fun getStatus(id: String): CatalystStatusV1_1 =
        httpClient.get<CatalystStatusV1_1Wrapper>("/catalyst/v1.1/status/$id").status

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

    suspend fun getAlbumsInStatus(id: String): List<CatalystAlbum> = httpClient.get("/catalyst/v1/status/$id/albums")

    suspend fun getReactions(id: String): List<CatalystReaction> = httpClient.get("/catalyst/v1/status/$id/reactions")

    suspend fun react(id: String, symbol: String) = httpClient.post("/catalyst/v1/status/$id/reactions/$symbol")

    suspend fun unreact(id: String, symbol: String) = httpClient.delete("/catalyst/v1/status/$id/reactions/$symbol")

    // Timelines
    suspend fun getContestTimeline(
        slug: String,
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/contest/by/slug/$slug",
        mapOf("since" to since, "until" to until)
    ).statuses

    suspend fun getFavoriteTimeline(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/favorite",
        mapOf("since" to since, "until" to until)
    ).statuses

    suspend fun getFirehoseTimeline(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatusV1_1> = httpClient.get(
        "/catalyst/v1.1/timeline/firehose",
        mapOf("since" to since, "until" to until)
    )

    suspend fun getGalleryTimeline(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/gallery",
        mapOf("since" to since, "until" to until)
    ).statuses

    suspend fun getHomeTimeline(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatusV1_1> = httpClient.get(
        "/catalyst/v1.1/timeline/home",
        mapOf("since" to since, "until" to until)
    )

    suspend fun searchTimeline(
        query: String,
        exact: Boolean = false,
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/search",
        mapOf(
            "q" to query,
            "exact" to exact.toString(),
            "since" to since,
            "until" to until
        )
    ).statuses

    suspend fun getUserTimeline(
        username: String,
        trimUser: Boolean = false,
        excludeSensitive: Boolean = true,
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/user/by/username/$username",
        mapOf(
            "trim_user" to trimUser.toString(),
            "exclude_sensitive" to excludeSensitive.toString(),
            "since" to since,
            "until" to until
        )
    ).statuses

    suspend fun getUserGalleryTimeline(
        username: String,
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/user/by/username/$username/gallery",
        mapOf("since" to since, "until" to until)
    ).statuses

    // Trends
    suspend fun getTrends(): List<String> = httpClient.get("/catalyst/v1/trend")

    // Contest operations
    suspend fun createContest(
        title: String,
        description: String,
        theme: String
    ): Identity = httpClient.postWithResult(
        "/catalyst/v1/contest",
        mapOf(
            "title" to title,
            "description" to description,
            "theme" to theme
        )
    )

    suspend fun getContestsByMe(): List<CatalystContest> = httpClient.get("/catalyst/v1/contest/by/me")

    suspend fun getCurrentContests(): List<CatalystContest> =
        httpClient.get<CatalystContestsWrapper>("/catalyst/v1/contest/current").contests

    suspend fun getContestBySlug(slug: String): CatalystContest =
        httpClient.get<CatalystContestWrapper>("/catalyst/v1/contest/by/slug/$slug").contest

    suspend fun editContest(
        slug: String,
        title: String? = null,
        description: String? = null,
        theme: String? = null,
        terms: String? = null,
        headerUrl: String? = null,
        bannerUrl: String? = null,
        winnersOpenAt: String? = null,
        winnersMessageSendAt: String? = null,
        publishedAt: String? = null,
        applicationSince: String? = null,
        applicationUntil: String? = null,
        applicationAllowSensitive: Boolean? = null,
        applicationMaxMediaPerEntry: Int? = null,
        votingSince: String? = null,
        votingUntil: String? = null,
        votingMaxVotes: Int? = null,
        votingIsEnableVoting: Boolean? = null,
        winnersSince: String? = null,
        winnersUntil: String? = null,
        ranks: List<Map<String, Any?>>? = null
    ) {
        val application = mapOf(
            "since" to applicationSince,
            "until" to applicationUntil,
            "allowSensitive" to applicationAllowSensitive,
            "maxMediaPerEntry" to applicationMaxMediaPerEntry
        ).filterValues { it != null }

        val voting = mapOf(
            "since" to votingSince,
            "until" to votingUntil,
            "maxVotes" to votingMaxVotes,
            "isEnableVoting" to votingIsEnableVoting
        ).filterValues { it != null }

        val winners = mapOf(
            "since" to winnersSince,
            "until" to winnersUntil
        ).filterValues { it != null }

        httpClient.patch(
            "/catalyst/v1/contest/by/slug/$slug",
            mapOf(
                "title" to title,
                "description" to description,
                "theme" to theme,
                "terms" to terms,
                "headerUrl" to headerUrl,
                "bannerUrl" to bannerUrl,
                "winnersOpenAt" to winnersOpenAt,
                "winnersMessageSendAt" to winnersMessageSendAt,
                "publishedAt" to publishedAt,
                "application" to application.ifEmpty { null },
                "voting" to voting.ifEmpty { null },
                "winners" to winners.ifEmpty { null },
                "ranks" to ranks
            ).filterValues { it != null }
        )
    }

    suspend fun getContestAwards(slug: String): List<CatalystContestAward> =
        httpClient.get<CatalystContestAwardsWrapper>("/catalyst/v1/contest/by/slug/$slug/awards").awards

    suspend fun setContestAward(
        slug: String,
        id: String,
        status: String,
        message: String? = null,
        commentary: String? = null
    ) = httpClient.post(
        "/catalyst/v1/contest/by/slug/$slug/awards/$id",
        mapOf(
            "status" to status,
            "message" to message,
            "commentary" to commentary
        ).filterValues { it != null }
    )

    suspend fun unsetContestAward(
        slug: String,
        id: String,
        status: String,
        message: String? = null,
        commentary: String? = null
    ) = httpClient.delete(
        "/catalyst/v1/contest/by/slug/$slug/awards/$id",
        mapOf(
            "status" to status,
            "message" to message,
            "commentary" to commentary
        ).filterValues { it != null }
    )

    suspend fun getContestCollaborators(slug: String): List<CatalystContestCollaborator> =
        httpClient.get<CatalystContestCollaboratorsWrapper>("/catalyst/v1/contest/by/slug/$slug/collaborators").collaborators

    suspend fun addContestCollaborator(
        slug: String,
        userId: String,
        role: String
    ) = httpClient.post(
        "/catalyst/v1/contest/by/slug/$slug/collaborators",
        mapOf("userId" to userId, "role" to role)
    )

    suspend fun removeContestCollaborator(
        slug: String,
        userId: String
    ) = httpClient.delete(
        "/catalyst/v1/contest/by/slug/$slug/collaborators",
        mapOf("userId" to userId)
    )

    suspend fun copyContest(slug: String): Identity = httpClient.postWithResult("/catalyst/v1/contest/by/slug/$slug/copy")

    suspend fun getAccessPermissionOfContest(slug: String): String =
        httpClient.get<CatalystContestAccessPermission>("/catalyst/v1/contest/by/slug/$slug/dashboard").result

    suspend fun getContestPolls(slug: String): List<CatalystContestPoll> =
        httpClient.get<CatalystContestPollsWrapper>("/catalyst/v1/contest/by/slug/$slug/polls").polls

    suspend fun publishContest(slug: String): Identity = httpClient.postWithResult("/catalyst/v1/contest/by/slug/$slug/publish")

    suspend fun addContestVoteToStatus(slug: String, id: String) = httpClient.post("/catalyst/v1/contest/by/slug/$slug/vote/$id")

    suspend fun removeContestVoteFromStatus(slug: String, id: String) = httpClient.delete("/catalyst/v1/contest/by/slug/$slug/vote/$id")

    suspend fun getContestVotes(slug: String): CatalystUserVoteRights = httpClient.get("/catalyst/v1/contest/by/slug/$slug/vote")

    suspend fun searchContest(
        state: String,
        query: String? = null
    ): List<CatalystContest> = httpClient.get<CatalystContestsWrapper>(
        "/catalyst/v1/contest/search",
        mapOf("state" to state, "q" to (query ?: ""))
    ).contests

    suspend fun getContestsByUser(username: String): List<CatalystContest> =
        httpClient.get<CatalystContestsWrapper>("/catalyst/v1/contest/by/user/$username").contests

    // Fleet operations
    suspend fun createFleet(
        backgroundColor: String,
        texts: List<Map<String, Any?>>,
        media: Map<String, Any?>,
        stickers: List<Map<String, Any?>>
    ) = httpClient.post(
        "/catalyst/v1/fleet",
        mapOf(
            "backgroundColor" to backgroundColor,
            "texts" to texts,
            "media" to media,
            "stickers" to stickers
        )
    )

    suspend fun getFleetById(id: String): CatalystFleet = httpClient.get("/catalyst/v1/fleet/$id")

    suspend fun deleteFleet(id: String) = httpClient.delete("/catalyst/v1/fleet/$id")

    suspend fun viewFleet(id: String) = httpClient.post("/catalyst/v1/fleet/$id/view")

    suspend fun getFleetViewers(id: String): List<CatalystFleetViewer> = httpClient.get("/catalyst/v1/fleet/$id/viewers")

    suspend fun reactFleet(id: String, symbol: String) = httpClient.post("/catalyst/v1/fleet/$id/reactions/$symbol")

    suspend fun unreactFleet(id: String, symbol: String) = httpClient.delete("/catalyst/v1/fleet/$id/reactions/$symbol")

    suspend fun getFleets(): List<CatalystFleetRing> = httpClient.get("/catalyst/v1/fleet/ring")

    suspend fun getFleetByUsername(username: String): List<CatalystFleet> = httpClient.get("/catalyst/v1/fleet/by/user/$username")
}
