// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonElement
import kotlin.time.ExperimentalTime

/**
 * Lifecycle state of a contest
 */
@Serializable
enum class CatalystContestState {
    @SerialName("draft")
    DRAFT,

    @SerialName("published")
    PUBLISHED,

    @SerialName("opening")
    OPENING,

    @SerialName("closing")
    CLOSING,

    @SerialName("voting")
    VOTING,

    @SerialName("electing")
    ELECTING,

    @SerialName("closed")
    CLOSED
}

/**
 * Voting window and configuration for a contest
 *
 * Note: [since]/[until] are ISO8601 strings (not `Instant`) because the real API may
 * return an empty string when the window is unset, which `Instant` cannot parse.
 */
@Serializable
data class CatalystContestVoting(
    val since: String,
    val until: String,
    val maxVotes: Int,
    val isEnable: Boolean
)

/**
 * A prize rank/tier within a contest
 */
@Serializable
data class CatalystContestRank(
    val id: String,
    val name: String,
    val description: String? = null,
    val count: Int,
    val prize: String,
    val winners: List<EgeriaUser>
)

/**
 * A contest hosted on the platform
 *
 * Note: [winnersOpenAt], [winnersMessageSendAt], [publishedAt], [since], and [until] are
 * ISO8601 strings (not `Instant`) because the real API may return an empty string when
 * these fields are unset, which `Instant` cannot parse.
 */
@Serializable
data class CatalystContest(
    val slug: String,
    val draft: Boolean,
    val state: CatalystContestState,
    val title: String,
    val description: String,
    val theme: String,
    val terms: String,
    val headerUrl: String,
    val bannerUrl: String,
    val organizer: EgeriaUser,
    val winnersOpenAt: String,
    val winnersMessageSendAt: String,
    val publishedAt: String,
    val since: String,
    val until: String,
    val allowSensitive: Boolean,
    val maxMediaPerEntry: Int? = null,
    val voting: CatalystContestVoting,
    val ranks: List<CatalystContestRank>
)

/**
 * Attachment metadata for a contest award winner
 */
@Serializable
data class CatalystContestAwardAttachment(
    val name: String,
    val id: String
)

/**
 * A single winning entry for a contest award
 *
 * This flattens the fields of [CatalystStatus] together with award-specific fields
 * ([message], [commentary], [attachment]), mirroring the TypeScript intersection type
 * `CatalystStatus & { message?, commentary?, attachment? }` used by the reference SDK.
 */
@Serializable
data class CatalystContestAwardWinner @OptIn(ExperimentalTime::class) constructor(
    val id: String,
    val body: String,
    val user: EgeriaUser? = null,
    val medias: List<Media>,
    val contest: CatalystStatusContest? = null,
    val createdAt: kotlin.time.Instant,
    val reactions: List<JsonElement>? = null,
    val message: String? = null,
    val commentary: String? = null,
    val attachment: CatalystContestAwardAttachment? = null
)

/**
 * An award category within a contest
 */
@Serializable
data class CatalystContestAward(
    val id: String,
    val name: String,
    val winners: List<CatalystContestAwardWinner>,
    val order: Int,
    val count: Int,
    val remaining: Int
)

/**
 * Role of a contest collaborator
 */
@Serializable
enum class CatalystContestCollaboratorRole {
    @SerialName("admin")
    ADMIN,

    @SerialName("collaborator")
    COLLABORATOR,

    @SerialName("contributor")
    CONTRIBUTOR
}

/**
 * A user collaborating on a contest
 */
@Serializable
data class CatalystContestCollaborator(
    val user: EgeriaUser,
    val role: CatalystContestCollaboratorRole
)

/**
 * A status submitted as a contest entry, along with its vote count
 */
@Serializable
data class CatalystContestPoll(
    val status: CatalystStatus,
    val count: Int
)

/**
 * The current user's remaining vote allowance for a contest
 */
@Serializable
data class CatalystUserVoteRights(
    val remaining: Int,
    val statuses: List<String>
)

/**
 * Wrapper for the `{"contest": {...}}` response shape
 */
@Serializable
data class CatalystContestWrapper(val contest: CatalystContest)

/**
 * Wrapper for the `{"contests": [...]}` response shape
 */
@Serializable
data class CatalystContestsWrapper(val contests: List<CatalystContest>)

/**
 * Wrapper for the `{"awards": [...]}` response shape
 */
@Serializable
data class CatalystContestAwardsWrapper(val awards: List<CatalystContestAward>)

/**
 * Wrapper for the `{"collaborators": [...]}` response shape
 */
@Serializable
data class CatalystContestCollaboratorsWrapper(val collaborators: List<CatalystContestCollaborator>)

/**
 * Wrapper for the `{"polls": [...]}` response shape
 */
@Serializable
data class CatalystContestPollsWrapper(val polls: List<CatalystContestPoll>)

/**
 * Access permission result for the current user on a contest dashboard.
 *
 * [result] is one of "admin" | "collaborator" | "contributor" | "guest"
 */
@Serializable
data class CatalystContestAccessPermission(val result: String)
