// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * A profile tag
 */
@Serializable
data class CatalystProfileTag(
    val id: String,
    val name: String,
    val normalizedName: String
)

/**
 * Wrapper for the `{"tags": [...]}` response shape
 */
@Serializable
internal data class CatalystProfileTagsWrapper(val tags: List<CatalystProfileTag>)

/**
 * A profile tag suggestion, including usage count
 */
@Serializable
data class CatalystProfileTagSuggestion(
    val id: String,
    val name: String,
    val usageCount: Int
)

/**
 * Wrapper for the `{"tags": [...]}` response shape (profile tag suggestions)
 */
@Serializable
internal data class CatalystProfileTagSuggestionsWrapper(val tags: List<CatalystProfileTagSuggestion>)

/**
 * A user matched by a profile tag search, including which tags matched
 */
@Serializable
data class CatalystProfileTagUser(
    val id: String,
    val screenName: String,
    val displayName: String,
    val profile: EgeriaUserProfile? = null,
    val profileEmoji: EgeriaUserProfileEmoji? = null,
    val matchedTags: List<String>
)

/**
 * Summary information for a profile tag (used within [CatalystProfileTagUsersResult])
 */
@Serializable
data class CatalystProfileTagSummary(
    val name: String,
    val usageCount: Int
)

/**
 * Result of listing users by profile tag, including cursor-based pagination
 */
@Serializable
data class CatalystProfileTagUsersResult(
    val tag: CatalystProfileTagSummary,
    val users: List<CatalystProfileTagUser>,
    val nextCursor: String? = null
)
