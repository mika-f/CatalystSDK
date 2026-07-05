// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * A world/scene registered on a given platform
 */
@Serializable
data class EpicleseWorld(
    val id: String,
    val platformIdentifier: String,
    val platform: EpiclesePlatform? = null,
    val name: String,
    val author: EpicleseAuthor? = null
)

/**
 * Wrapper for the `{"world": {...} | null}` response shape
 */
@Serializable
internal data class EpicleseWorldWrapper(val world: EpicleseWorld? = null)

/**
 * Wrapper for the `{"items": [...]}` response shape
 */
@Serializable
internal data class EpicleseWorldsResult(val items: List<EpicleseWorld>)
