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
        title: String,
        description: String? = null,
        isPublic: Boolean? = null,
        mode: CatalystAlbumDisplayMode? = null
    ): Identity = httpClient.postWithResult(
        "/catalyst/v1/album",
        mapOf(
            "title" to title,
            "description" to description,
            "isPublic" to isPublic,
            "mode" to mode
        ).filterValues { it != null }
    )

    suspend fun getAlbum(
        id: String,
        limit: Int? = null,
        since: String? = null,
        until: String? = null
    ): CatalystAlbum = httpClient.get(
        "/catalyst/v1/album/by/id/$id",
        mapOf("limit" to limit?.toString(), "since" to since, "until" to until)
    )

    suspend fun insertToAlbum(id: String, statusId: String): CatalystResult = httpClient.putWithResult(
        "/catalyst/v1/album/by/id/$id",
        mapOf("insert" to statusId)
    )

    suspend fun removeFromAlbum(id: String, statusId: String): CatalystResult = httpClient.putWithResult(
        "/catalyst/v1/album/by/id/$id",
        mapOf("remove" to statusId)
    )

    suspend fun editAlbum(
        id: String,
        title: String,
        description: String? = null,
        isPublic: Boolean? = null,
        mode: CatalystAlbumDisplayMode? = null
    ): CatalystResult = httpClient.patchWithResult(
        "/catalyst/v1/album/by/id/$id",
        mapOf(
            "title" to title,
            "description" to description,
            "isPublic" to isPublic,
            "mode" to mode
        ).filterValues { it != null }
    )

    suspend fun deleteAlbum(id: String): CatalystResult = httpClient.deleteWithResult("/catalyst/v1/album/by/id/$id")

    suspend fun getAlbumBooks(id: String): List<CatalystAlbumBook> = httpClient.get("/catalyst/v1/album/by/id/$id/book")

    suspend fun createAlbumBook(
        id: String,
        template: String,
        quality: String,
        coverImageUrl: String? = null,
        subtitle: String? = null,
        customText: String? = null,
        showBody: Boolean? = null,
        showDate: Boolean? = null,
        showUrl: Boolean? = null,
        showQrCode: Boolean? = null,
        tocType: String? = null,
        colophonText: String? = null
    ): CatalystAlbumBook = httpClient.postWithResult(
        "/catalyst/v1/album/by/id/$id/book",
        mapOf(
            "template" to template,
            "quality" to quality,
            "coverImageUrl" to coverImageUrl,
            "subtitle" to subtitle,
            "customText" to customText,
            "showBody" to showBody,
            "showDate" to showDate,
            "showUrl" to showUrl,
            "showQrCode" to showQrCode,
            "tocType" to tocType,
            "colophonText" to colophonText
        ).filterValues { it != null }
    )

    suspend fun getAlbumBook(id: String, bookId: String): CatalystAlbumBook = httpClient.get("/catalyst/v1/album/by/id/$id/book/$bookId")

    suspend fun regenerateAlbumBook(id: String, bookId: String): CatalystAlbumBook =
        httpClient.postWithResult("/catalyst/v1/album/by/id/$id/book/$bookId/regenerate")

    suspend fun getAlbumsByMe(includeSmartAlbums: Boolean = false): List<CatalystSmartAlbum> =
        httpClient.get<CatalystSmartAlbums>(
            "/catalyst/v1/album/by/me",
            mapOf("include_smart_albums" to includeSmartAlbums.toString())
        ).albums

    suspend fun listAlbums(
        username: String,
        includeSmartAlbum: Boolean = true
    ): List<CatalystSmartAlbum> = httpClient.get<CatalystSmartAlbums>(
        "/catalyst/v1/album/by/user/$username",
        mapOf("include_smart_album" to includeSmartAlbum.toString())
    ).albums

    suspend fun searchAlbums(
        query: String? = null,
        includeSmartAlbum: Boolean = true,
        until: String? = null
    ): List<CatalystSmartAlbum> = httpClient.get<CatalystSmartAlbums>(
        "/catalyst/v1/album/search",
        mapOf("q" to query, "include_smart_album" to includeSmartAlbum.toString(), "until" to until)
    ).albums

    // Announcements
    suspend fun getAnnouncements(): List<CatalystAnnouncement> =
        httpClient.get<CatalystAnnouncementsWrapper>("/catalyst/v1/announcements").announcements

    // Blocks
    suspend fun block(userId: String): CatalystResult = httpClient.postWithResult(
        "/catalyst/v1/blocks",
        mapOf("userId" to userId)
    )

    suspend fun unblock(userId: String): CatalystResult = httpClient.deleteWithResult(
        "/catalyst/v1/blocks",
        mapOf("userId" to userId)
    )

    // Contest operations
    // Note: the spec only exposes read + vote operations for contests; contest management
    // (create/edit/awards/collaborators/copy/dashboard/publish/polls) is no longer part of the API.
    suspend fun getContestsByMe(): List<CatalystContest> =
        httpClient.get<CatalystContestsWrapper>("/catalyst/v1/contest/by/me").contests

    suspend fun getContestBySlug(slug: String): CatalystContest =
        httpClient.get<CatalystContestWrapper>("/catalyst/v1/contest/by/slug/$slug").contest

    suspend fun getContestTimeline(slug: String): List<CatalystStatus> =
        httpClient.get<CatalystStatuses>("/catalyst/v1/contest/by/slug/$slug/timeline").statuses

    suspend fun getContestVotes(slug: String): CatalystUserVoteRights = httpClient.get("/catalyst/v1/contest/by/slug/$slug/vote")

    suspend fun addContestVote(slug: String, status: String): CatalystResult =
        httpClient.postWithResult("/catalyst/v1/contest/by/slug/$slug/vote/$status")

    suspend fun removeContestVote(slug: String, status: String): CatalystResult =
        httpClient.deleteWithResult("/catalyst/v1/contest/by/slug/$slug/vote/$status")

    suspend fun getContestsByUser(userId: String): List<CatalystContest> =
        httpClient.get<CatalystContestsWrapper>("/catalyst/v1/contest/by/user/$userId").contests

    suspend fun getCurrentContests(): List<CatalystContest> =
        httpClient.get<CatalystContestsWrapper>("/catalyst/v1/contest/current").contests

    suspend fun searchContests(
        query: String? = null,
        state: String? = null,
        id: String? = null
    ): List<CatalystContest> = httpClient.get<CatalystContestsWrapper>(
        "/catalyst/v1/contest/search",
        mapOf("q" to query, "state" to state, "id" to id)
    ).contests

    // Custom reactions
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

    suspend fun updateCustomReaction(
        id: String,
        displayName: String? = null,
        sortOrder: Int? = null
    ): CatalystUserCustomReaction = httpClient.patchWithResult(
        "/catalyst/v1/custom-reactions/$id",
        mapOf(
            "displayName" to displayName,
            "sortOrder" to sortOrder
        ).filterValues { it != null }
    )

    suspend fun deleteCustomReaction(id: String) = httpClient.delete("/catalyst/v1/custom-reactions/$id")

    // Fleet operations
    suspend fun createFleet(
        backgroundColor: String,
        texts: List<Map<String, Any?>>,
        media: Map<String, Any?>,
        stickers: List<Map<String, Any?>>
    ): Identity = httpClient.postWithResult(
        "/catalyst/v1/fleet",
        mapOf(
            "backgroundColor" to backgroundColor,
            "texts" to texts,
            "media" to media,
            "stickers" to stickers
        )
    )

    suspend fun getFleetByUsername(username: String): List<CatalystFleet> = httpClient.get("/catalyst/v1/fleet/by/user/$username")

    suspend fun getFleets(): List<CatalystFleetRing> = httpClient.get("/catalyst/v1/fleet/ring")

    suspend fun getFleetById(id: String): CatalystFleet = httpClient.get("/catalyst/v1/fleet/$id")

    suspend fun deleteFleet(id: String): CatalystResult = httpClient.deleteWithResult("/catalyst/v1/fleet/$id")

    suspend fun reactFleet(id: String, symbol: String): CatalystReactionValue =
        httpClient.postWithResult("/catalyst/v1/fleet/$id/reactions/$symbol")

    suspend fun unreactFleet(id: String, symbol: String): CatalystReactionValue =
        httpClient.deleteWithResult("/catalyst/v1/fleet/$id/reactions/$symbol")

    suspend fun viewFleet(id: String): CatalystResult = httpClient.postWithResult("/catalyst/v1/fleet/$id/view")

    suspend fun getFleetViewers(id: String): List<CatalystFleetViewer> = httpClient.get("/catalyst/v1/fleet/$id/viewers")

    // Privacy
    suspend fun getPrivacySettings(): CatalystPrivacySettings = httpClient.get("/catalyst/v1/privacy/settings")

    suspend fun updatePrivacySettings(
        followingListVisibility: String,
        followerListVisibility: String
    ): CatalystPrivacySettings = httpClient.patchWithResult(
        "/catalyst/v1/privacy/settings",
        mapOf(
            "followingListVisibility" to followingListVisibility,
            "followerListVisibility" to followerListVisibility
        )
    )

    // Profile tags
    suspend fun updateProfileTags(tags: List<String>): List<CatalystProfileTag> =
        httpClient.putWithResult<CatalystProfileTagsWrapper>("/catalyst/v1/profile-tags", mapOf("tags" to tags)).tags

    suspend fun getUsersByProfileTag(
        name: String,
        cursor: String? = null
    ): CatalystProfileTagUsersResult = httpClient.get(
        "/catalyst/v1/profile-tags/by/name/$name/users",
        mapOf("cursor" to cursor)
    )

    suspend fun getProfileTagsByUser(userId: String): List<CatalystProfileTag> =
        httpClient.get<CatalystProfileTagsWrapper>("/catalyst/v1/profile-tags/by/user/$userId").tags

    suspend fun getProfileTagSuggestions(query: String): List<CatalystProfileTagSuggestion> =
        httpClient.get<CatalystProfileTagSuggestionsWrapper>(
            "/catalyst/v1/profile-tags/suggestions",
            mapOf("q" to query)
        ).tags

    // Random
    suspend fun getRandomStatus(): CatalystStatus? =
        httpClient.get<CatalystNullableStatusV1Wrapper>("/catalyst/v1/random").status

    suspend fun getRandomStatusV1_1(): CatalystStatusV1_1 = httpClient.get("/catalyst/v1.1/random")

    suspend fun getOnThisDay(): CatalystStatusV1_1 = httpClient.get("/catalyst/v1.1/on-this-day")

    // Reactions
    suspend fun getOriginalReactions(): List<CatalystCustomReaction> = httpClient.get("/catalyst/v1/reactions")

    // Relationships
    suspend fun follow(userId: String): CatalystResult = httpClient.postWithResult(
        "/catalyst/v1/relationships",
        mapOf("userId" to userId)
    )

    suspend fun remove(userId: String): CatalystResult = httpClient.deleteWithResult(
        "/catalyst/v1/relationships",
        mapOf("userId" to userId)
    )

    suspend fun getRelationshipCounts(username: String): CatalystRelationshipsCount =
        httpClient.get("/catalyst/v1/relationships/by/username/$username/counts")

    suspend fun getFollowers(username: String, page: Int? = null): CatalystFollowingOrFollowersList = httpClient.get(
        "/catalyst/v1/relationships/by/username/$username/followers",
        mapOf("page" to page?.toString())
    )

    suspend fun getFollowings(username: String, page: Int? = null): CatalystFollowingOrFollowersList = httpClient.get(
        "/catalyst/v1/relationships/by/username/$username/followings",
        mapOf("page" to page?.toString())
    )

    suspend fun getRelationships(userId: String): CatalystRelationships = httpClient.get("/catalyst/v1/relationships/$userId")

    // Smart album operations
    suspend fun createSmartAlbum(
        title: String,
        description: String,
        hashtags: List<String>,
        since: String? = null,
        until: String? = null,
        isAllowNsfw: Boolean? = null,
        isAllowOthers: Boolean? = null,
        isPublic: Boolean? = null,
        mode: CatalystAlbumDisplayMode? = null
    ): Identity = httpClient.postWithResult(
        "/catalyst/v1/smart-album",
        mapOf(
            "title" to title,
            "description" to description,
            "hashtags" to hashtags,
            "since" to since,
            "until" to until,
            "isAllowNsfw" to isAllowNsfw,
            "isAllowOthers" to isAllowOthers,
            "isPublic" to isPublic,
            "mode" to mode
        ).filterValues { it != null }
    )

    suspend fun getSmartAlbum(
        id: String,
        limit: Int? = null,
        since: String? = null,
        until: String? = null
    ): CatalystSmartAlbum = httpClient.get(
        "/catalyst/v1/smart-album/by/id/$id",
        mapOf("limit" to limit?.toString(), "since" to since, "until" to until)
    )

    suspend fun editSmartAlbum(
        id: String,
        title: String,
        description: String,
        hashtags: List<String>,
        since: String? = null,
        until: String? = null,
        isAllowNsfw: Boolean? = null,
        isAllowOthers: Boolean? = null,
        isPublic: Boolean? = null,
        mode: CatalystAlbumDisplayMode? = null
    ): CatalystSmartAlbum = httpClient.patchWithResult(
        "/catalyst/v1/smart-album/by/id/$id",
        mapOf(
            "title" to title,
            "description" to description,
            "hashtags" to hashtags,
            "since" to since,
            "until" to until,
            "isAllowNsfw" to isAllowNsfw,
            "isAllowOthers" to isAllowOthers,
            "isPublic" to isPublic,
            "mode" to mode
        ).filterValues { it != null }
    )

    suspend fun deleteSmartAlbum(id: String): CatalystResult = httpClient.deleteWithResult("/catalyst/v1/smart-album/by/id/$id")

    suspend fun getSmartAlbumBooks(id: String): List<CatalystAlbumBook> = httpClient.get("/catalyst/v1/smart-album/by/id/$id/book")

    suspend fun createSmartAlbumBook(
        id: String,
        template: String,
        quality: String,
        coverImageUrl: String? = null,
        subtitle: String? = null,
        customText: String? = null,
        showBody: Boolean? = null,
        showDate: Boolean? = null,
        showUrl: Boolean? = null,
        showQrCode: Boolean? = null,
        tocType: String? = null,
        colophonText: String? = null
    ): CatalystAlbumBook = httpClient.postWithResult(
        "/catalyst/v1/smart-album/by/id/$id/book",
        mapOf(
            "template" to template,
            "quality" to quality,
            "coverImageUrl" to coverImageUrl,
            "subtitle" to subtitle,
            "customText" to customText,
            "showBody" to showBody,
            "showDate" to showDate,
            "showUrl" to showUrl,
            "showQrCode" to showQrCode,
            "tocType" to tocType,
            "colophonText" to colophonText
        ).filterValues { it != null }
    )

    suspend fun getSmartAlbumBook(id: String, bookId: String): CatalystAlbumBook = httpClient.get("/catalyst/v1/smart-album/by/id/$id/book/$bookId")

    suspend fun regenerateSmartAlbumBook(id: String, bookId: String): CatalystAlbumBook =
        httpClient.postWithResult("/catalyst/v1/smart-album/by/id/$id/book/$bookId/regenerate")

    suspend fun getSmartAlbumsByUser(userId: String): List<CatalystSmartAlbum> =
        httpClient.get<CatalystSmartAlbums>("/catalyst/v1/smart-album/by/user/$userId").albums

    suspend fun searchSmartAlbums(query: String? = null): List<CatalystSmartAlbum> = httpClient.get<CatalystSmartAlbums>(
        "/catalyst/v1/smart-album/search",
        mapOf("q" to query)
    ).albums

    // Status operations
    suspend fun createStatus(
        description: String,
        media: List<Map<String, Any?>> = emptyList(),
        isNsfw: Boolean = false,
        isSpoiler: Boolean = false,
        isSubmitToContest: Boolean = false,
        isHidingLikeAndViewCount: Boolean = false,
        isPrivateMetadata: Boolean? = null,
        isAllowComments: Boolean = true,
        privacy: CatalystStatusPrivacy? = null,
        contestId: String? = null
    ): Identity = httpClient.postWithResult(
        "/catalyst/v1/status",
        mapOf(
            "description" to description,
            "isNsfw" to isNsfw,
            "isSpoiler" to isSpoiler,
            "isSubmitToContest" to isSubmitToContest,
            "isHidingLikeAndViewCount" to isHidingLikeAndViewCount,
            "isPrivateMetadata" to isPrivateMetadata,
            "isAllowComments" to isAllowComments,
            "privacy" to privacy,
            "contestId" to contestId,
            "media" to media
        ).filterValues { it != null }
    )

    suspend fun getStatus(id: String): CatalystStatus =
        httpClient.get<CatalystStatusV1Wrapper>("/catalyst/v1/status/$id").status

    suspend fun getStatusV1_1(id: String): CatalystStatusV1_1 =
        httpClient.get<CatalystStatusV1_1Wrapper>("/catalyst/v1.1/status/$id").status

    suspend fun editStatus(id: String, description: String): Identity = httpClient.patchWithResult(
        "/catalyst/v1/status/$id",
        mapOf("description" to description)
    )

    suspend fun deleteStatus(id: String): CatalystMessage = httpClient.deleteWithResult("/catalyst/v1/status/$id")

    suspend fun getAlbumsInStatus(id: String): List<CatalystAlbum> =
        httpClient.get<CatalystAlbumsWrapper>("/catalyst/v1/status/$id/albums").albums

    suspend fun isFavorited(id: String): Boolean = httpClient.get("/catalyst/v1/status/$id/favorite")

    suspend fun favorite(id: String): CatalystResult = httpClient.postWithResult("/catalyst/v1/status/$id/favorite")

    suspend fun unfavorite(id: String): CatalystResult = httpClient.deleteWithResult("/catalyst/v1/status/$id/favorite")

    suspend fun getReactions(id: String): Map<String, CatalystReaction> =
        httpClient.get<CatalystReactions>("/catalyst/v1/status/$id/reactions").reactions

    suspend fun reactWithCustomReaction(id: String, customReactionId: String) =
        httpClient.post("/catalyst/v1/status/$id/reactions/custom/$customReactionId")

    suspend fun unreactWithCustomReaction(id: String, customReactionId: String) =
        httpClient.delete("/catalyst/v1/status/$id/reactions/custom/$customReactionId")

    suspend fun react(id: String, symbol: String): CatalystReactionValue =
        httpClient.postWithResult("/catalyst/v1/status/$id/reactions/$symbol")

    suspend fun unreact(id: String, symbol: String): CatalystReactionValue =
        httpClient.deleteWithResult("/catalyst/v1/status/$id/reactions/$symbol")

    suspend fun reportStatus(
        id: String,
        reason: String,
        description: String? = null
    ): Identity = httpClient.postWithResult(
        "/catalyst/v1/status/$id/report",
        mapOf("reason" to reason, "description" to description).filterValues { it != null }
    )

    // Bulk status reactions
    suspend fun getBulkStatusReactions(ids: List<String>): Map<String, Map<String, CatalystReaction>> =
        httpClient.postWithResult<CatalystBulkStatusReactions>(
            "/catalyst/v1/statuses/reactions",
            mapOf("ids" to ids)
        ).reactions

    // Timelines
    suspend fun getArchiveTimeline(
        year: Int,
        month: Int,
        day: Int? = null,
        since: String? = null,
        until: String? = null,
        userId: String? = null,
        limit: Int? = null,
        excludeSensitive: Boolean? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/archive",
        mapOf(
            "year" to year.toString(),
            "month" to month.toString(),
            "day" to day?.toString(),
            "since" to since,
            "until" to until,
            "userId" to userId,
            "limit" to limit?.toString(),
            "excludeSensitive" to excludeSensitive?.toString()
        )
    ).statuses

    suspend fun getArchiveMonths(): List<CatalystArchiveMonth> =
        httpClient.get<CatalystArchiveMonths>("/catalyst/v1/timeline/archive/months").months

    suspend fun getTimelineByContestSlug(
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
    ): List<CatalystStatusV1_1> = httpClient.get<CatalystStatusesV1_1>(
        "/catalyst/v1/timeline/favorite",
        mapOf("since" to since, "until" to until)
    ).statuses

    suspend fun getFirehoseTimelineV1(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/firehose",
        mapOf("since" to since, "until" to until)
    ).statuses

    suspend fun getGalleryTimeline(
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/gallery",
        mapOf("since" to since, "until" to until)
    ).statuses

    suspend fun getHomeTimelineV1(): List<CatalystStatus> =
        httpClient.get<CatalystStatuses>("/catalyst/v1/timeline/home").statuses

    suspend fun searchTimeline(
        query: String? = null,
        exact: Boolean? = null,
        since: String? = null,
        until: String? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/search",
        mapOf(
            "q" to query,
            "exact" to exact?.toString(),
            "since" to since,
            "until" to until
        )
    ).statuses

    suspend fun getUserTimeline(
        username: String,
        since: String? = null,
        until: String? = null,
        limit: Int? = null,
        excludeSensitive: Boolean? = null
    ): List<CatalystStatus> = httpClient.get<CatalystStatuses>(
        "/catalyst/v1/timeline/user/by/username/$username",
        mapOf(
            "since" to since,
            "until" to until,
            "limit" to limit?.toString(),
            "exclude_sensitive" to excludeSensitive?.toString()
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

    suspend fun getFirehoseTimeline(
        since: String? = null,
        until: String? = null,
        trimVisitor: Boolean? = null
    ): List<CatalystStatusV1_1> = httpClient.get(
        "/catalyst/v1.1/timeline/firehose",
        mapOf("since" to since, "until" to until, "trim_visitor" to trimVisitor?.toString())
    )

    suspend fun getHomeTimeline(
        since: String? = null,
        until: String? = null,
        trimVisitor: Boolean? = null
    ): List<CatalystStatusV1_1> = httpClient.get(
        "/catalyst/v1.1/timeline/home",
        mapOf("since" to since, "until" to until, "trim_visitor" to trimVisitor?.toString())
    )

    // Trends
    suspend fun getTrends(): List<String>? = httpClient.get("/catalyst/v1/trend")

    suspend fun getRichTrends(): List<CatalystRichTrendingItem>? = httpClient.get(
        "/catalyst/v1/trend",
        mapOf("format" to "rich")
    )
}
