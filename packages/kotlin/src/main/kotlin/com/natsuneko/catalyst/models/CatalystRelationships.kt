// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Relationship information between users
 */
@Serializable
data class CatalystRelationships(
    val isMyself: Boolean,
    val isFollowing: Boolean,
    val isFollowed: Boolean,
    val isBlocking: Boolean
)

/**
 * Following/follower counts for a user
 */
@Serializable
data class CatalystRelationshipsCount(
    val followings: Int? = null,
    val followers: Int? = null
)

/**
 * Paginated list of a user's followers or followings
 */
@Serializable
data class CatalystFollowingOrFollowersList(
    val items: List<EgeriaUser>,
    val count: CatalystCountInfo,
    val page: CatalystPageInfo
)
