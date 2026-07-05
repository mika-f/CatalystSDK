// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonElement

/**
 * Notification
 */
@Serializable
data class Notification(
    val id: String,
    val title: String,
    val isGrouped: Boolean,
    val belongsTo: JsonElement,
    val entities: List<NotificationGroup>,
    val hasMore: Boolean,
    val read: Boolean
)

/**
 * Additional context for a notification group (e.g. custom reaction)
 */
@Serializable
data class NotificationAdditionalContext(
    val type: String,
    val url: String,
    val format: String
)

/**
 * Notification group
 */
@Serializable
data class NotificationGroup(
    val id: String,
    val body: String,
    val occurredBy: EgeriaUser,
    val isRead: Boolean,
    val createdAt: String,
    val additionalContexts: NotificationAdditionalContext? = null
)

/**
 * Notification unread count
 */
@Serializable
data class NotificationUnreadCount(
    val unread: Int
)

/**
 * Wrapper for the `{"notifications": [...]}` response shape
 */
@Serializable
internal data class Notifications(val notifications: List<Notification>)
