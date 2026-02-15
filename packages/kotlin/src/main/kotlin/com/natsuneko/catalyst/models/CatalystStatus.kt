// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable
import kotlin.time.ExperimentalTime

/**
 * Social media status (post)
 */
@Serializable
data class CatalystStatus @OptIn(ExperimentalTime::class) constructor(
    val id: String,
    val body: String,
    val user: EgeriaUser? = null,
    val medias: List<Media>,
    val createdAt: kotlin.time.Instant,
    val updatedAt: kotlin.time.Instant? = null
)
