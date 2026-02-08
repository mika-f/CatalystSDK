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
 * Notification group
 */
@Serializable
data class NotificationGroup(
    val id: String,
    val body: String,
    val occurredBy: EgeriaUser,
    val isRead: Boolean
)

/**
 * Notification unread count
 */
@Serializable
data class NotificationUnreadCount(
    val count: Int
)
