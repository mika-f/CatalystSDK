// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * User information
 */
@Serializable
data class EgeriaUser(
    val id: String,
    val screenName: String,
    val displayName: String,
    val profile: EgeriaUserProfile? = null
)

@Serializable
data class EgeriaUserWrapper (val user: EgeriaUser)
