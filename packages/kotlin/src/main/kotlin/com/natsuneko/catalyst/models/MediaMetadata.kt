// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Metadata for media attachments
 */
@Serializable
data class MediaMetadata(
    val width: Int? = null,
    val height: Int? = null,
    val isSensitive: Boolean,
    val isSpoiler: Boolean
)
