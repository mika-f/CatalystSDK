// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.http

import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.engine.cio.*
import io.ktor.client.plugins.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.plugins.logging.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import kotlinx.serialization.json.Json

/**
 * HTTP client for Catalyst API
 * Provides type-safe HTTP operations with automatic serialization/deserialization
 */
class CatalystHttpClient(
    @PublishedApi
    internal val baseUrl: String = "https://api.natsuneko.com",
    accessToken: String? = null,
    private val userAgent: String = "CatalystKotlin/0.1.0",
    private val configure: HttpClientConfig<*>.() -> Unit = {}
) {
    @PublishedApi
    internal val client = HttpClient(CIO) {
        install(ContentNegotiation) {
            json(Json {
                ignoreUnknownKeys = true
                isLenient = true
                encodeDefaults = true
                prettyPrint = false
                coerceInputValues = true
            })
        }

        install(Logging) {
            logger = Logger.DEFAULT
            level = LogLevel.INFO
        }

        install(DefaultRequest) {
            header(HttpHeaders.UserAgent, userAgent)
            accessToken?.let {
                header(HttpHeaders.Authorization, "Bearer $it")
            }
        }

        install(HttpTimeout) {
            requestTimeoutMillis = 30_000
            connectTimeoutMillis = 10_000
            socketTimeoutMillis = 30_000
        }

        configure()
    }

    /**
     * Performs a GET request
     */
    suspend inline fun <reified T> get(
        path: String,
        queryParams: Map<String, String?> = emptyMap()
    ): T {
        val response: HttpResponse = client.get("$baseUrl$path") {
            queryParams.forEach { (key, value) ->
                value?.let { parameter(key, it) }
            }
        }
        return response.body()
    }

    /**
     * Performs a POST request with typed return value
     */
    suspend inline fun <reified T> postWithResult(
        path: String,
        body: Any? = null
    ): T {
        val response: HttpResponse = client.post("$baseUrl$path") {
            contentType(ContentType.Application.Json)
            body?.let { setBody(it) }
        }
        return response.body()
    }

    /**
     * Performs a POST request without return value
     */
    suspend fun post(
        path: String,
        body: Any? = null
    ) {
        client.post("$baseUrl$path") {
            contentType(ContentType.Application.Json)
            body?.let { setBody(it) }
        }
    }

    /**
     * Performs a PATCH request
     */
    suspend fun patch(
        path: String,
        body: Any
    ) {
        client.patch("$baseUrl$path") {
            contentType(ContentType.Application.Json)
            setBody(body)
        }
    }

    /**
     * Performs a PUT request
     */
    suspend fun put(
        path: String,
        body: Any
    ) {
        client.put("$baseUrl$path") {
            contentType(ContentType.Application.Json)
            setBody(body)
        }
    }

    /**
     * Performs a DELETE request
     */
    suspend fun delete(path: String) {
        client.delete("$baseUrl$path")
    }

    /**
     * Performs a DELETE request with body
     */
    suspend fun delete(
        path: String,
        body: Any
    ) {
        client.delete("$baseUrl$path") {
            contentType(ContentType.Application.Json)
            setBody(body)
        }
    }

    /**
     * Performs a GET request and returns raw bytes
     */
    suspend fun getRaw(path: String): ByteArray {
        val response: HttpResponse = client.get("$baseUrl$path")
        return response.body()
    }

    /**
     * Creates a new client with updated access token
     */
    fun withAccessToken(token: String): CatalystHttpClient {
        return CatalystHttpClient(
            baseUrl = baseUrl,
            accessToken = token,
            userAgent = userAgent,
            configure = configure
        )
    }

    /**
     * Closes the HTTP client
     */
    fun close() {
        client.close()
    }
}
