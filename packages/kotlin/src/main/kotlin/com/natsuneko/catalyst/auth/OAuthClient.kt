// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.auth

import com.natsuneko.catalyst.PUBLIC_API_ENDPOINT
import com.natsuneko.catalyst.PUBLIC_AUTHORIZE_ENDPOINT
import com.natsuneko.catalyst.models.Token
import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.engine.cio.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.request.*
import io.ktor.client.request.forms.*
import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import kotlinx.serialization.json.Json

/**
 * OAuth 2.0 client for Catalyst authentication
 */
class OAuthClient(
    private val clientId: String,
    private val clientSecret: String
) {
    private val httpClient = HttpClient(CIO) {
        install(ContentNegotiation) {
            json(Json {
                ignoreUnknownKeys = true
                isLenient = true
            })
        }
    }

    /**
     * Exchanges an authorization code for an access token
     *
     * @param code The authorization code received from the OAuth provider
     * @param redirectUri The redirect URI used in the authorization request
     * @param pkce The PKCE instance used for the authorization request
     * @return Token containing access and refresh tokens
     */
    suspend fun getAccessTokenByCode(
        code: String,
        redirectUri: String,
        pkce: Pkce
    ): Token {
        val response = httpClient.submitForm(
            url = "$PUBLIC_API_ENDPOINT/token",
            formParameters = parameters {
                append("grant_type", "authorization_code")
                append("code", code)
                append("redirect_uri", redirectUri)
                append("client_id", clientId)
                append("code_verifier", pkce.verifier)
            }
        )
        return response.body()
    }

    /**
     * Refreshes an access token using a refresh token
     *
     * @param refreshToken The refresh token
     * @return Token containing new access and refresh tokens
     */
    suspend fun getAccessTokenByRefreshToken(refreshToken: String): Token {
        val response = httpClient.submitForm(
            url = "$PUBLIC_API_ENDPOINT/token",
            formParameters = parameters {
                append("grant_type", "refresh_token")
                append("refresh_token", refreshToken)
                append("client_id", clientId)
                append("client_secret", clientSecret)
            }
        )
        return response.body()
    }

    /**
     * Generates the authorization URL for the OAuth flow
     *
     * @param redirectUri The redirect URI to use
     * @param pkce The PKCE instance for this authorization request
     * @param state A random state value for CSRF protection
     * @return The authorization URL
     */
    fun getAuthorizeUrl(
        redirectUri: String,
        pkce: Pkce,
        state: String
    ): String {
        return URLBuilder(PUBLIC_AUTHORIZE_ENDPOINT).apply {
            parameters.append("response_type", "code")
            parameters.append("client_id", clientId)
            parameters.append("redirect_uri", redirectUri)
            parameters.append("state", state)
            parameters.append("code_challenge", pkce.challenge)
            parameters.append("code_challenge_method", pkce.method)
        }.buildString()
    }

    /**
     * Extracts the authorization code from the callback URL
     *
     * @param callbackUrl The full callback URL received from the OAuth provider
     * @param expectedState The expected state value
     * @param expectedRedirectUri The expected redirect URI
     * @return The authorization code
     * @throws IllegalArgumentException if validation fails
     */
    fun getAuthorizationCode(
        callbackUrl: String,
        expectedState: String,
        expectedRedirectUri: String
    ): String {
        val url = Url(callbackUrl)

        // Verify redirect URI
        val baseUrl = "${url.protocol.name}://${url.host}${url.encodedPath}"
        require(baseUrl == expectedRedirectUri) {
            "Invalid redirect URI: expected $expectedRedirectUri, got $baseUrl"
        }

        // Verify state
        val state = url.parameters["state"]
        require(state == expectedState) {
            "Invalid state: expected $expectedState, got $state"
        }

        // Check for errors
        val error = url.parameters["error"]
        if (error != null) {
            val errorDescription = url.parameters["error_description"]
            val errorUri = url.parameters["error_uri"]
            throw OAuthException(error, errorDescription, errorUri)
        }

        // Extract code
        return url.parameters["code"]
            ?: throw IllegalArgumentException("No authorization code in callback URL")
    }

    /**
     * Closes the HTTP client
     */
    fun close() {
        httpClient.close()
    }
}

/**
 * Exception thrown during OAuth flow
 */
class OAuthException(
    val error: String,
    val description: String?,
    val uri: String?
) : Exception("OAuth error: $error${description?.let { " - $it" } ?: ""}")
