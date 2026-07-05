// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.models

import kotlinx.serialization.Serializable

/**
 * Wrapper for the `{"flags": [...]}` response shape
 */
@Serializable
internal data class CatalystFeatureFlags(val flags: List<String>)
