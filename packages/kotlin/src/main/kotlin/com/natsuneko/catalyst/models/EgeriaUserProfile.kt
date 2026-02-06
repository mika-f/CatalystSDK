// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * User profile information
 */
@Serializable
data class EgeriaUserProfile(
    val iconUrl: String,
    val bannerUrl: String,
    val bio: String,
    val website: String,
    val additionalWebsites: List<String>
)
