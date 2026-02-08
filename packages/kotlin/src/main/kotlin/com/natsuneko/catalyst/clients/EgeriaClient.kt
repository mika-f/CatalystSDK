// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.clients

import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.EgeriaUser

/**
 * Client for Egeria (User Management) API endpoints
 */
class EgeriaClient internal constructor(
    private val httpClient: CatalystHttpClient
) {
    /**
     * Gets the current authenticated user
     */
    suspend fun getCurrentUser(): EgeriaUser? = httpClient.get("/egeria/v1/me")

    /**
     * Updates the current user's profile
     */
    suspend fun updateProfile(
        iconUrl: String? = null,
        bannerUrl: String? = null,
        bio: String? = null,
        website: String? = null,
        additionalWebsites: List<String>? = null
    ) = httpClient.patch(
        "/egeria/v1/me",
        mapOf(
            "iconUrl" to iconUrl,
            "bannerUrl" to bannerUrl,
            "bio" to bio,
            "website" to website,
            "additionalWebsites" to additionalWebsites
        ).filterValues { it != null }
    )

    /**
     * Searches for users by query
     */
    suspend fun searchUsers(query: String): List<EgeriaUser> = httpClient.get(
        "/egeria/v1/search",
        mapOf("q" to query)
    )

    /**
     * Gets a user by ID
     */
    suspend fun getUserById(id: String): EgeriaUser? = httpClient.get("/egeria/v1/user/by/id/$id")

    /**
     * Gets a user by username
     */
    suspend fun getUserByUsername(username: String): EgeriaUser? = httpClient.get("/egeria/v1/user/by/username/$username")
}
