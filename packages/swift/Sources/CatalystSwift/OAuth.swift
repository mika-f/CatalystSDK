// Licensed under the MIT License
//
// Copyright (c) 2024 Jiro Matsuzawa
// Copyright (c) 2025 Natsune Mochizuki
// ref: https://qiita.com/jmatsuzawa/items/b870ccb3e2d566c91422

import AuthenticationServices
import Foundation
import SwiftUI

public enum OAuthError: Error {
    case AuthorizationRequestFailed(ErrorInfo)
    case InvalidAuthorizationResponse
    case InvalidTokenResponse
}

public struct ErrorInfo: Codable, Sendable {
    let error: String
    let description: String?
    let uri: String?
}

public final class OAuth: Sendable {
    private let client: CatalystSwift

    init(client: CatalystSwift) {
        self.client = client
    }

    public func getAccessTokenByCode(using code: String, redirectUri: String, pkce: PKCE) async throws -> Token {
        var req = URLRequest(url: URL(string: "\(PUBLIC_API_ENDPOINT)/token")!)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")

        let params = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": redirectUri,
            "client_id": client.clientId,
            "code_verifier": pkce.verifier,
        ]

        req.httpBody = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)

        let (payload, response) = try await URLSession.shared.data(for: req)
        guard let status = (response as? HTTPURLResponse)?.statusCode else {
            throw OAuthError.InvalidTokenResponse
        }
        guard status == 200 else {
            throw OAuthError.InvalidTokenResponse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            return try decoder.decode(Token.self, from: payload)
        } catch {
            throw OAuthError.InvalidTokenResponse
        }
    }

    public func getAuthorizeURL(callback _: ASWebAuthenticationSession.Callback, redirectUri: String, pkce: PKCE, state: String) throws -> URL {
        var components = URLComponents(string: PUBLIC_AUTHORIZE_ENDPOINT)!
        components.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: client.clientId),
            URLQueryItem(name: "redirect_uri", value: redirectUri),
            URLQueryItem(name: "state", value: state),
            URLQueryItem(name: "code_challenge", value: pkce.challenge),
            URLQueryItem(name: "code_challenge_method", value: pkce.method),
        ]

        return components.url!
    }

    public func getAuthorizationCode(from url: URL, expectedState: String, expectedRedirectUri: String) throws -> String {
        try verifyAuthorizationResponse(url: url, expectedState: expectedState, expectedRedirectUri: expectedRedirectUri)
        let items = URLComponents(string: url.absoluteString)!.queryItems!
        if let error = items.first(where: { $0.name == "error" })?.value {
            throw OAuthError.AuthorizationRequestFailed(ErrorInfo(
                error: error,
                description: items.first(where: { $0.name == "error_description" })?.value,
                uri: items.first(where: { $0.name == "error_uri" })?.value
            ))
        }

        guard let code = items.first(where: { $0.name == "code" })?.value else {
            throw OAuthError.InvalidAuthorizationResponse
        }

        return code
    }

    private func verifyAuthorizationResponse(url: URL, expectedState: String, expectedRedirectUri: String) throws {
        guard url.absoluteString.hasPrefix(expectedRedirectUri + "?") else {
            throw OAuthError.InvalidAuthorizationResponse
        }

        guard let items = URLComponents(string: url.absoluteString)!.queryItems else {
            throw OAuthError.InvalidAuthorizationResponse
        }

        guard items.first(where: { $0.name == "state" })?.value == expectedState else {
            throw OAuthError.InvalidAuthorizationResponse
        }
    }
}
