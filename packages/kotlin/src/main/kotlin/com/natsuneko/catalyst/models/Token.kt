// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/**
 * OAuth token response
 */
@Serializable
data class Token(
    @SerialName("access_token")
    val accessToken: String,

    @SerialName("refresh_token")
    val refreshToken: String,

    @SerialName("token_type")
    val tokenType: String
)
