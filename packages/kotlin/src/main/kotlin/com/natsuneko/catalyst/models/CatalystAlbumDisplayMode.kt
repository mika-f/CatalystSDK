// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/**
 * Display mode for albums
 */
@Serializable
enum class CatalystAlbumDisplayMode {
    @SerialName("timeline")
    TIMELINE,

    @SerialName("grid")
    GRID,

    @SerialName("gallery")
    GALLERY
}
