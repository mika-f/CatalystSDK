// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

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
internal data class CatalystContestWrapper(val contest: CatalystContest)

/**
 * Wrapper for the `{"contests": [...]}` response shape
 */
@Serializable
internal data class CatalystContestsWrapper(val contests: List<CatalystContest>)
