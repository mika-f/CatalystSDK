// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * URLs for media upload
 */
@Serializable
data class MediaUploadUrls(
    val url: String,
    val signedUrl: String
)
