// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Identity response containing an ID
 */
@Serializable
data class Identity(
    val id: String
)
