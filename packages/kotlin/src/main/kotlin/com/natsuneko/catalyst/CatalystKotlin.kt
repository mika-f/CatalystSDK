// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst

import com.natsuneko.catalyst.auth.OAuthClient
import com.natsuneko.catalyst.clients.CatalystClient
import com.natsuneko.catalyst.clients.EgeriaClient
import com.natsuneko.catalyst.clients.MediaClient
import com.natsuneko.catalyst.clients.SteambirdClient
import com.natsuneko.catalyst.http.CatalystHttpClient
import com.natsuneko.catalyst.models.Token
import kotlinx.serialization.json.Json

/**
 * Main client for the Catalyst platform
 *
 * This is the primary entry point for interacting with the Catalyst API.
 * It provides access to various API clients and handles authentication.
 *
 * @property clientId The OAuth client ID
 * @property clientSecret The OAuth client secret
 * @property accessToken The current access token (if authenticated)
 * @property refreshToken The current refresh token (if authenticated)
 */
class CatalystKotlin(
    val clientId: String,
    val clientSecret: String,
    private var accessToken: String? = null,
    private var refreshToken: String? = null
) : AutoCloseable {
    private var httpClient: CatalystHttpClient = createHttpClient()

    private val _oauth: OAuthClient by lazy { OAuthClient(clientId, clientSecret) }
    private val _catalyst: CatalystClient by lazy { CatalystClient(httpClient) }
    private val _egeria: EgeriaClient by lazy { EgeriaClient(httpClient) }
    private val _media: MediaClient by lazy { MediaClient(httpClient) }
    private val _steambird: SteambirdClient by lazy { SteambirdClient(httpClient) }

    /**
     * OAuth client for authentication operations
     */
    val oauth: OAuthClient get() = _oauth

    /**
     * Catalyst client for status, album, and timeline operations
     */
    val catalyst: CatalystClient get() = _catalyst

    /**
     * Egeria client for user management operations
     */
    val egeria: EgeriaClient get() = _egeria

    /**
     * Media client for media upload and download operations
     */
    val media: MediaClient get() = _media

    /**
     * Steambird client for notification operations
     */
    val steambird: SteambirdClient get() = _steambird

    /**
     * Sets the authentication credentials
     *
     * @param accessToken The access token
     * @param refreshToken The refresh token
     */
    fun setCredentials(accessToken: String, refreshToken: String) {
        this.accessToken = accessToken
        this.refreshToken = refreshToken
        updateHttpClient()
    }

    /**
     * Sets the authentication credentials from a token object
     *
     * @param token The token object containing access and refresh tokens
     */
    fun setCredentials(token: Token) {
        setCredentials(token.accessToken, token.refreshToken)
    }

    /**
     * Clears the authentication credentials
     */
    fun clearCredentials() {
        this.accessToken = null
        this.refreshToken = null
        updateHttpClient()
    }

    /**
     * Refreshes the access token using the refresh token
     *
     * @return The new token
     * @throws IllegalStateException if no refresh token is available
     */
    suspend fun refresh(): Token {
        val currentRefreshToken = refreshToken
            ?: throw IllegalStateException("No refresh token available. Please authenticate first.")

        val token = oauth.getAccessTokenByRefreshToken(currentRefreshToken)
        setCredentials(token)
        return token
    }

    private fun createHttpClient(): CatalystHttpClient {
        return CatalystHttpClient(
            accessToken = accessToken
        )
    }

    private fun updateHttpClient() {
        httpClient.close()
        httpClient = createHttpClient()
    }

    /**
     * Closes the HTTP client and releases resources
     */
    override fun close() {
        httpClient.close()
        _oauth.close()
    }

    companion object {
        /**
         * Decodes JSON data into a typed object
         *
         * Useful for parsing webhook payloads or other JSON data
         *
         * @param T The type to decode into
         * @param json The JSON string
         * @return The decoded object
         */
        inline fun <reified T> decode(json: String): T {
            return Json {
                ignoreUnknownKeys = true
                isLenient = true
                coerceInputValues = true
            }.decodeFromString(json)
        }

        /**
         * Decodes JSON bytes into a typed object
         *
         * @param T The type to decode into
         * @param bytes The JSON bytes
         * @return The decoded object
         */
        inline fun <reified T> decode(bytes: ByteArray): T {
            return decode(bytes.decodeToString())
        }
    }
}
