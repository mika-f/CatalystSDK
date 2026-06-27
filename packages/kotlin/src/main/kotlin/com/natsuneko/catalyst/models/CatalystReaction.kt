// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Reaction to a status
 */
@Serializable
data class CatalystReaction(
    val name: String,
    val symbol: String,
    val url: String,
    val count: Int,
    val hasSelfReaction: Boolean? = null
)

/**
 * Standard emoji reaction definition (GET /catalyst/v1/reactions)
 */
@Serializable
data class CatalystCustomReaction(
    val id: String,
    val name: String,
    val symbol: String,
    val url: String
)

/**
 * User-defined custom reaction (items in GET /catalyst/v1/custom-reactions)
 */
@Serializable
data class CatalystUserCustomReaction(
    val id: String,
    val shortcode: String,
    val displayName: String,
    val imageUrl: String,
    val mimeType: String,
    val sortOrder: Int,
    val status: String,
    val createdAt: String
)

/**
 * List of user-defined custom reactions with plan information
 */
@Serializable
data class CatalystCustomReactionList(
    val plan: String,
    val limit: Int,
    val used: Int,
    val items: List<CatalystUserCustomReaction>
)
