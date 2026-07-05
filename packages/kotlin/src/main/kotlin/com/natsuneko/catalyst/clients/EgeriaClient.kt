// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.clients

import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.EgeriaUser
import com.natsuneko.catalyst.models.EgeriaUserWrapper
import com.natsuneko.catalyst.models.EgeriaUsersWrapper

/**
 * Client for Egeria (User Management) API endpoints
 */
class EgeriaClient internal constructor(
    private val httpClient: CatalystHttpClient
) {
    /**
     * Gets the current authenticated user
     */
    suspend fun getCurrentUser(): EgeriaUserWrapper? = httpClient.get("/egeria/v1/me")

    /**
     * Updates the current user's profile
     *
     * Note: [iconUrl]/[bannerUrl]/[bio]/[website]/[additionalWebsites] are nested under the
     * `profile` key in the request body, matching the `User` request schema.
     */
    suspend fun updateProfile(
        screenName: String? = null,
        displayName: String? = null,
        iconUrl: String? = null,
        bannerUrl: String? = null,
        bio: String? = null,
        website: String? = null,
        additionalWebsites: List<String>? = null
    ) = httpClient.patch(
        "/egeria/v1/me",
        mapOf(
            "screenName" to screenName,
            "displayName" to displayName,
            "profile" to mapOf(
                "iconUrl" to iconUrl,
                "bannerUrl" to bannerUrl,
                "bio" to bio,
                "website" to website,
                "additionalWebsites" to additionalWebsites
            ).filterValues { it != null }.ifEmpty { null }
        ).filterValues { it != null }
    )

    /**
     * Searches for users by query
     */
    suspend fun searchUsers(query: String): List<EgeriaUser> = httpClient.get<EgeriaUsersWrapper>(
        "/egeria/v1/search",
        mapOf("q" to query)
    ).users

    /**
     * Gets a user by ID
     */
    suspend fun getUserById(id: String): EgeriaUserWrapper? = httpClient.get("/egeria/v1/user/by/id/$id")

    /**
     * Gets a user by username
     */
    suspend fun getUserByUsername(username: String): EgeriaUserWrapper? = httpClient.get("/egeria/v1/user/by/username/$username")
}
