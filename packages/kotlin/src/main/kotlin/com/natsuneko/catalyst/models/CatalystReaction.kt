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
    val name: String,
    val symbol: String,
    val url: String
)
