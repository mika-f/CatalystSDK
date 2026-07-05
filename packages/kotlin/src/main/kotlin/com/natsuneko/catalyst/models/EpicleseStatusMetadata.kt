// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * A single tagged reference (e.g. a face/area tagged in a photo) within a status metadata tag
 */
@Serializable
data class EpicleseStatusMetadataReference(
    val x: Double,
    val y: Double,
    val reference: String? = null,
    val type: String,
    val name: String,
    val description: String? = null,
    val externalUrl: String? = null,
    val author: EpicleseAuthor? = null
)

/**
 * Metadata tagged onto a status, keyed by tag id.
 *
 * `GET`/`POST /epiclese/v1/tag/by/status/{id}` return a `Map<String, EpicleseStatusMetadataTag>` keyed by tag id.
 */
@Serializable
data class EpicleseStatusMetadataTag(
    val platform: String? = null,
    val world: EpicleseWorld? = null,
    val users: List<EgeriaUser>,
    val reference: List<EpicleseStatusMetadataReference>,
    val additionalData: Map<String, String>? = null
)
