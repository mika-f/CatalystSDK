// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Total/offset counters used by several list endpoints
 */
@Serializable
data class CatalystCountInfo(
    val total: Int,
    val offset: Int
)

/**
 * Page cursor metadata used by several list endpoints
 */
@Serializable
data class CatalystPageInfo(
    val min: Int,
    val max: Int,
    val current: Int,
    val next: Int? = null,
    val prev: Int? = null
)
