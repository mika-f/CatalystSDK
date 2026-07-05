// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Privacy settings for the current user's following/follower lists
 *
 * [followingListVisibility] and [followerListVisibility] are one of "public" | "private".
 * GET and PATCH `/catalyst/v1/privacy/settings` share this same shape for request and response.
 */
@Serializable
data class CatalystPrivacySettings(
    val followingListVisibility: String,
    val followerListVisibility: String
)
