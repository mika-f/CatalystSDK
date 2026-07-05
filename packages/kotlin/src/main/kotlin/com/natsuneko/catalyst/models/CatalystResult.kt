// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Generic `{"result": boolean}` response shape used by many mutation endpoints
 */
@Serializable
data class CatalystResult(val result: Boolean)

/**
 * Generic `{"value": number}` response shape used by reaction toggle endpoints
 */
@Serializable
data class CatalystReactionValue(val value: Int)

/**
 * Generic `{"message": string}` response shape
 */
@Serializable
data class CatalystMessage(val message: String)
