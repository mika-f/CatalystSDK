// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.datetime.Instant
import kotlinx.serialization.Serializable

/**
 * Smart album with automatic content filtering
 */
@Serializable
data class CatalystSmartAlbum(
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
