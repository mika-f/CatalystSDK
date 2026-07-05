// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.clients

import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.CatalystResult
import com.natsuneko.catalyst.models.Notification
import com.natsuneko.catalyst.models.NotificationUnreadCount
import com.natsuneko.catalyst.models.Notifications

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
     * Gets notifications for a specific issuer, or all issuers if omitted
     */
    suspend fun getNotifications(
        issuer: String? = null,
        since: String? = null,
        until: String? = null
    ): List<Notification> = httpClient.get<Notifications>(
        "/steambird/v1/notifications",
        mapOf(
            "issuer" to issuer,
            "since" to since,
            "until" to until
        )
    ).notifications

    /**
     * Marks a notification as read
     */
    suspend fun markAsRead(notificationId: String): CatalystResult =
        httpClient.postWithResult("/steambird/v1/notifications/$notificationId")

    /**
     * Marks all notifications as read
     */
    suspend fun markAllAsRead(issuer: String? = null): CatalystResult = httpClient.postWithResult(
        "/steambird/v1/notifications/all",
        queryParams = mapOf("issuer" to issuer)
    )

    /**
     * Gets the unread notification count
     */
    suspend fun getUnreadCount(
        issuer: String? = null,
        issuers: List<String>? = null
    ): NotificationUnreadCount = httpClient.get(
        "/steambird/v1/notifications/unread",
        mapOf("issuer" to issuer, "issuers" to issuers?.joinToString(","))
    )
}
