// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Wrapper for the `{"reactions": {statusId: {symbol: Reaction}}}` response shape returned by
 * `POST /catalyst/v1/statuses/reactions`
 */
@Serializable
internal data class CatalystBulkStatusReactions(val reactions: Map<String, Map<String, CatalystReaction>>)
