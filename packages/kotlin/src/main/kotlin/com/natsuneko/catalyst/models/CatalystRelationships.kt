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
    val isFollowed: Boolean
)
