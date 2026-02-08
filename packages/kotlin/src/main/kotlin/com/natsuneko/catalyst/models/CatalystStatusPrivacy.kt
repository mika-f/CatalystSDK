// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/**
 * Privacy settings for a status
 */
@Serializable
enum class CatalystStatusPrivacy {
    @SerialName("public")
    PUBLIC,

    @SerialName("quiet_public")
    QUIET_PUBLIC,

    @SerialName("followers")
    FOLLOWERS,

    @SerialName("private")
    PRIVATE
}
