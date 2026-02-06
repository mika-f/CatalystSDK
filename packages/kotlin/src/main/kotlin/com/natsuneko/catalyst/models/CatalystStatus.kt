// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.datetime.Instant
import kotlinx.serialization.Serializable

/**
 * Social media status (post)
 */
@Serializable
data class CatalystStatus(
    val id: String,
    val body: String,
    val user: EgeriaUser? = null,
    val medias: List<Media>,
    val createdAt: Instant,
    val updatedAt: Instant? = null
)
