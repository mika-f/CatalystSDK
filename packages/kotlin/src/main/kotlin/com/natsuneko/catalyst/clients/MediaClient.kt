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
     * Downloads media by URL
     */
    suspend fun download(url: String): ByteArray = httpClient.post(
        "/media/v1/download",
        mapOf("url" to url)
    )

    /**
     * Deletes media by ID
     */
    suspend fun delete(mediaId: String) = httpClient.delete(
        "/media/v1/upload",
        mapOf("mediaId" to mediaId)
    )

    /**
     * Gets a signed URL for uploading media
     */
    suspend fun getUploadUrl(): MediaUploadUrls = httpClient.post("/media/v2/upload")
}
