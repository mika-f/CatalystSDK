// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable
import kotlin.time.ExperimentalTime

/**
 * A platform recognized by Epiclese (e.g. VRChat, Resonite)
 */
@Serializable
data class EpiclesePlatform @OptIn(ExperimentalTime::class) constructor(
    val id: String,
    val name: String,
    val description: String,
    val url: String? = null,
    val startAt: kotlin.time.Instant? = null
)

/**
 * Wrapper for the `{"platform": {...}}` response shape
 */
@Serializable
internal data class EpiclesePlatformWrapper(val platform: EpiclesePlatform)

/**
 * Wrapper for the `{"platforms": [...]}` response shape
 */
@Serializable
internal data class EpiclesePlatformsWrapper(val platforms: List<EpiclesePlatform>)
