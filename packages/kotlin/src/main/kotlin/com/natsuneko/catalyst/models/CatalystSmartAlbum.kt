// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable
import kotlin.time.ExperimentalTime
import kotlin.time.Instant

/**
 * Smart album with automatic content filtering
 */
@Serializable
data class CatalystSmartAlbum @OptIn(ExperimentalTime::class) constructor(
    val id: String,
    val name: String,
    val description: String,
    val isAllowNsfw: Boolean,
    val isAllowOthers: Boolean,
    val since: Instant? = null,
    val until: Instant? = null,
    val isPublic: Boolean,
    val mode: CatalystAlbumDisplayMode,
    val user: EgeriaUser? = null,
    val type: String? = null,
    val statuses: List<CatalystStatus>,
    val hashtags: List<String>
)
