// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable
import kotlin.time.ExperimentalTime

/**
 * Placement (position/scale/rotation) of a fleet element
 */
@Serializable
data class CatalystFleetPlacement(
    val posX: Double,
    val posY: Double,
    val scale: Double,
    val rotation: Double
)

/**
 * A text overlay on a fleet
 */
@Serializable
data class CatalystFleetText(
    val id: String,
    val body: String,
    val textStyle: String,
    val textAlignment: String,
    val color: String,
    val backgroundColor: String? = null,
    val posX: Double,
    val posY: Double,
    val scale: Double,
    val rotation: Double
)

/**
 * A sticker overlay on a fleet
 */
@Serializable
data class CatalystFleetSticker(
    val id: String,
    val emoji: String,
    val posX: Double,
    val posY: Double,
    val scale: Double,
    val rotation: Double
)

/**
 * Media attached to a fleet
 */
@Serializable
data class CatalystFleetMedia(
    val url: String,
    val alt: String,
    val width: Int? = null,
    val height: Int? = null,
    val placement: CatalystFleetPlacement? = null
)

/**
 * A fleet (ephemeral status)
 */
@Serializable
data class CatalystFleet @OptIn(ExperimentalTime::class) constructor(
    val id: String,
    val backgroundColor: String,
    val renderedImageUrl: String? = null,
    val user: EgeriaUser,
    val texts: List<CatalystFleetText>,
    val media: CatalystFleetMedia?,
    val stickers: List<CatalystFleetSticker>,
    val reactions: Map<String, CatalystReaction>,
    val viewCount: Int,
    val createdAt: kotlin.time.Instant,
    val expiresAt: kotlin.time.Instant
)

/**
 * A viewer of a fleet
 */
@Serializable
data class CatalystFleetViewer @OptIn(ExperimentalTime::class) constructor(
    val user: EgeriaUser,
    val viewedAt: kotlin.time.Instant
)

/**
 * A user's fleet ring summary (used for the fleet ring/tray UI)
 */
@Serializable
data class CatalystFleetRing(
    val user: EgeriaUser,
    val hasUnread: Boolean,
    val fleetCount: Int
)
