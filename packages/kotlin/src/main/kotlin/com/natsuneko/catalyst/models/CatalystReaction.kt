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
 * Custom reaction definition
 */
@Serializable
data class CatalystCustomReaction(
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
 * List of custom reactions with plan information
 */
@Serializable
data class CatalystCustomReactionList(
    val plan: String,
    val limit: Int,
    val used: Int,
    val items: List<CatalystCustomReaction>
)
