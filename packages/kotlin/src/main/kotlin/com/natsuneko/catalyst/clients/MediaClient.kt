// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.clients

import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.MediaUploadUrls

/**
 * Client for Media API endpoints
 */
class MediaClient internal constructor(
    private val httpClient: CatalystHttpClient
) {
    /**
     * Gets a signed URL for uploading media (v1)
     */
    suspend fun getUploadUrl(): MediaUploadUrls = httpClient.postWithResult("/media/v1/upload")

    /**
     * Downloads media by URL
     *
     * Not documented in the current OpenAPI spec, but still supported by the live API.
     */
    suspend fun download(url: String): ByteArray = httpClient.postWithResult(
        "/media/v1/download",
        mapOf("url" to url)
    )

    /**
     * Deletes media by URL
     */
    suspend fun delete(url: String): Boolean = httpClient.deleteWithResult(
        "/media/v1/upload",
        mapOf("url" to url)
    )

    /**
     * Gets a signed URL for uploading media (v2)
     */
    suspend fun getUploadUrlV2(): MediaUploadUrls = httpClient.postWithResult("/media/v2/upload")
}
