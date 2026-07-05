// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * User information
 */
@Serializable
data class EgeriaUser(
    val id: String,
    val screenName: String,
    val displayName: String,
    val profile: EgeriaUserProfile? = null,
    val profileEmoji: EgeriaUserProfileEmoji? = null
)

/**
 * The current user's profile emoji.
 *
 * This is a flattened representation of the `anyOf` union defined by the spec, discriminated
 * by [type]:
 * - `"standard"` populates [value] and [imageUrl]
 * - `"custom"` populates [id], [shortcode], [displayName], [imageUrl], [width] and [height]
 */
@Serializable
data class EgeriaUserProfileEmoji(
    val type: String,
    val value: String? = null,
    val id: String? = null,
    val shortcode: String? = null,
    val displayName: String? = null,
    val imageUrl: String? = null,
    val width: Double? = null,
    val height: Double? = null
)

@Serializable
data class EgeriaUserWrapper(val user: EgeriaUser)

/**
 * Wrapper for the `{"users": [...]}` response shape
 */
@Serializable
internal data class EgeriaUsersWrapper(val users: List<EgeriaUser>)
