// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable
import kotlin.time.ExperimentalTime

/**
 * A platform-wide announcement
 */
@Serializable
data class CatalystAnnouncement @OptIn(ExperimentalTime::class) constructor(
    val id: String,
    val title: String,
    val body: String,
    val category: String,
    val since: kotlin.time.Instant,
    val until: kotlin.time.Instant,
    val url: String? = null
)

/**
 * Wrapper for the `{"announcements": [...]}` response shape
 */
@Serializable
internal data class CatalystAnnouncementsWrapper(val announcements: List<CatalystAnnouncement>)
