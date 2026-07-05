// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable
import kotlin.time.ExperimentalTime

/**
 * A generated photo/record book for an album or smart album
 *
 * [template] is one of "photo-book" | "record-book"
 * [quality] is one of "web" | "print"
 * [tocType] is one of "per-post" | "page-only" | null
 * [status] is one of "pending" | "processing" | "completed" | "failed"
 */
@Serializable
data class CatalystAlbumBook @OptIn(ExperimentalTime::class) constructor(
    val id: String,
    val albumId: String? = null,
    val smartAlbumId: String? = null,
    val template: String,
    val quality: String,
    val coverImageUrl: String? = null,
    val subtitle: String? = null,
    val customText: String? = null,
    val showBody: Boolean,
    val showDate: Boolean,
    val showUrl: Boolean,
    val tocType: String? = null,
    val colophonText: String? = null,
    val status: String,
    val errorMessage: String? = null,
    val downloadUrl: String? = null,
    val expiresAt: kotlin.time.Instant? = null,
    val createdAt: kotlin.time.Instant? = null,
    val updatedAt: kotlin.time.Instant? = null
)
