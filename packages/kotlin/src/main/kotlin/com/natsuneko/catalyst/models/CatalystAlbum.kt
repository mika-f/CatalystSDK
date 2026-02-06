// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Album containing multiple statuses
 */
@Serializable
data class CatalystAlbum(
    val id: String,
    val name: String,
    val description: String,
    val isPublic: Boolean,
    val mode: CatalystAlbumDisplayMode,
    val user: EgeriaUser,
    val statuses: List<CatalystStatus>
)
