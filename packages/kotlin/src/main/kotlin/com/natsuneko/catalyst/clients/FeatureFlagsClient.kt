// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.clients

import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.CatalystFeatureFlags

/**
 * Client for Feature Flags API endpoints
 */
class FeatureFlagsClient internal constructor(
    private val httpClient: CatalystHttpClient
) {
    /**
     * Gets the feature flags enabled for the current user
     */
    suspend fun getMyFeatureFlags(): List<String> =
        httpClient.get<CatalystFeatureFlags>("/feature-flags/v1/me").flags
}
