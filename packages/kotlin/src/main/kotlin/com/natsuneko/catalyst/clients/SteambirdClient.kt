// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.clients

import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.Notification
import com.natsuneko.catalyst.models.NotificationUnreadCount

/**
 * Client for Steambird (Notifications) API endpoints
 */
class SteambirdClient internal constructor(
    private val httpClient: CatalystHttpClient
) {
    companion object {
        const val ISSUER_CATALYST_SYSTEM_MESSAGE = "natsuneko-laboratory:catalyst"
        const val ISSUER_CATALYST_USER_MESSAGE = "natsuneko-laboratory:catalyst-message"
        const val ISSUER_EGERIA_SYSTEM_MESSAGE = "natsuneko-laboratory:egeria"
    }

    /**
     * Gets notifications for a specific issuer
     */
    suspend fun getNotifications(
        issuer: String,
        since: String? = null,
        until: String? = null
    ): List<Notification> = httpClient.get(
        "/steambird/v1/notifications",
        mapOf(
            "issuer" to issuer,
            "since" to since,
            "until" to until
        )
    )

    /**
     * Marks a notification as read
     */
    suspend fun markAsRead(notificationId: String) = httpClient.post("/steambird/v1/notifications/$notificationId")

    /**
     * Marks all notifications as read
     */
    suspend fun markAllAsRead(issuer: String? = null) = httpClient.post(
        "/steambird/v1/notifications/all",
        issuer?.let { mapOf("issuer" to it) }
    )

    /**
     * Gets the unread notification count
     */
    suspend fun getUnreadCount(issuers: List<String>? = null): NotificationUnreadCount = httpClient.get(
        "/steambird/v1/notifications/unread",
        issuers?.let { mapOf("issuers" to it.joinToString(",")) } ?: emptyMap()
    )
}
