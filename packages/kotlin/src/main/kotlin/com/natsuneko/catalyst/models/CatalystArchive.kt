// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * A single month bucket in the status archive
 */
@Serializable
data class CatalystArchiveMonth(
    val year: Int,
    val month: Int,
    val count: Int
)

/**
 * Wrapper for the `{"months": [...]}` response shape
 */
@Serializable
internal data class CatalystArchiveMonths(val months: List<CatalystArchiveMonth>)
