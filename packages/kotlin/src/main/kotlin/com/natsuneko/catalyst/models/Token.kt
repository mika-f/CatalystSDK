// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlin.time.ExperimentalTime

/**
 * OAuth token response
 */
@Serializable
data class Token @OptIn(ExperimentalTime::class) constructor(
    @SerialName("access_token")
    val accessToken: String,

    @SerialName("refresh_token")
    val refreshToken: String,

    @SerialName("token_type")
    val tokenType: String,

    @SerialName("scope")
    val scope: String? = null,

    @SerialName("expires_at")
    val expiresAt: kotlin.time.Instant? = null,

    @SerialName("expires_in")
    val expiresIn: Int? = null
)
