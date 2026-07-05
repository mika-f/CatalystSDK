// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonElement
import kotlin.time.ExperimentalTime

/**
 * Contest metadata attached to a status submitted as a contest entry
 */
@Serializable
data class CatalystStatusContest(
    val slug: String,
    val title: String,
    val headerUrl: String,
    val bannerUrl: String? = null
)

/**
 * Social media status (post) - v1 shape
 *
 * Used for `/catalyst/v1/status/{id}`, `/catalyst/v1/timeline/{name}` (except firehose/home which are v1.1),
 * status lists inside albums, contest polls, and contest award winners.
 */
@Serializable
data class CatalystStatus @OptIn(ExperimentalTime::class) constructor(
    val id: String,
    val body: String,
    val user: EgeriaUser? = null,
    val medias: List<Media>,
    val contest: CatalystStatusContest? = null,
    val createdAt: kotlin.time.Instant,
    /**
     * Deprecated: this field is always serialized as an empty array by the real API.
     * Use [com.natsuneko.catalyst.clients.CatalystClient.getReactions] to fetch reactions instead.
     */
    @Deprecated("Use getReactions() instead")
    val reactions: List<JsonElement>? = null
)

/**
 * Visitor-specific state for a status (v1.1 shape only)
 */
@Serializable
data class CatalystStatusVisitor(
    val favorite: Boolean,
    val reactions: List<String>? = null
)

/**
 * Social media status (post) - v1.1 shape
 *
 * Used for `/catalyst/v1.1/status/{id}`, `/catalyst/v1.1/timeline/firehose`, and `/catalyst/v1.1/timeline/home`.
 */
@Serializable
data class CatalystStatusV1_1 @OptIn(ExperimentalTime::class) constructor(
    val id: String,
    val body: String,
    val user: EgeriaUser? = null,
    val medias: List<Media>,
    val contest: CatalystStatusContest? = null,
    val reactions: Map<String, CatalystReaction>,
    val createdAt: kotlin.time.Instant,
    val updatedAt: kotlin.time.Instant,
    val visitor: CatalystStatusVisitor? = null,
    val privacy: CatalystStatusPrivacy
)

/**
 * Wrapper for the `{"status": {...}}` response shape (v1.1 shape, used by `/catalyst/v1.1/status/{id}`)
 */
@Serializable
internal data class CatalystStatusV1_1Wrapper(val status: CatalystStatusV1_1)

/**
 * Wrapper for the `{"status": {...}}` response shape (v1 shape, used by `/catalyst/v1/status/{id}`)
 */
@Serializable
internal data class CatalystStatusV1Wrapper(val status: CatalystStatus)

/**
 * Wrapper for the `{"status": {...} | null}` response shape, used by `/catalyst/v1/random`
 */
@Serializable
internal data class CatalystNullableStatusV1Wrapper(val status: CatalystStatus? = null)

/**
 * Wrapper for the `{"statuses": [...]}` response shape
 */
@Serializable
internal data class CatalystStatuses(val statuses: List<CatalystStatus>)

/**
 * Wrapper for the `{"statuses": [...]}` response shape (v1.1 shape)
 */
@Serializable
internal data class CatalystStatusesV1_1(val statuses: List<CatalystStatusV1_1>)
