// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Media attachment (image, video, etc.)
 */
@Serializable
data class Media(
    val id: String,
    val alt: String,
    val url: String,
    val metadata: MediaMetadata? = null,
    val privacyMetadata: Boolean? = null
)
