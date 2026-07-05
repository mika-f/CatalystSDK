// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * The author/creator of a world on a given platform
 */
@Serializable
data class EpicleseAuthor(
    val id: String,
    val platformIdentifier: String,
    val platform: EpiclesePlatform? = null,
    val name: String
)

/**
 * Wrapper for the `{"author": {...}}` response shape
 */
@Serializable
internal data class EpicleseAuthorWrapper(val author: EpicleseAuthor)

/**
 * Paginated result of listing/searching authors
 */
@Serializable
data class EpicleseAuthorsResult(
    val items: List<EpicleseAuthor>,
    val count: CatalystCountInfo,
    val page: CatalystPageInfo
)
