// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

package com.natsuneko.catalyst.auth

import java.security.MessageDigest
import java.security.SecureRandom
import java.util.Base64

/**
 * PKCE (Proof Key for Code Exchange) implementation
 * Used for OAuth 2.0 authorization code flow with enhanced security
 */
class Pkce {
    /**
     * The code verifier
     */
    val verifier: String

    /**
     * The code challenge derived from the verifier
     */
    val challenge: String

    /**
     * The challenge method (always S256 for SHA-256)
     */
    val method: String = "S256"

    init {
        verifier = generateVerifier()
        challenge = computeChallenge(verifier)
    }

    private fun generateVerifier(): String {
        val random = SecureRandom()
        val bytes = ByteArray(32)
        random.nextBytes(bytes)
        return base64UrlEncode(bytes)
    }

    private fun computeChallenge(verifier: String): String {
        val digest = MessageDigest.getInstance("SHA-256")
        val hash = digest.digest(verifier.toByteArray(Charsets.UTF_8))
        return base64UrlEncode(hash)
    }

    private fun base64UrlEncode(bytes: ByteArray): String {
        return Base64.getUrlEncoder()
            .withoutPadding()
            .encodeToString(bytes)
    }
}
