// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * A single entry in the "rich" trending list (`GET /catalyst/v1/trend?format=rich`)
 *
 * [movement] is one of "up" | "down" | "same" | "new"
 */
@Serializable
data class CatalystRichTrendingItem(
    val tag: String,
    val rank: Int,
    val previousRank: Int? = null,
    val movement: String
)
