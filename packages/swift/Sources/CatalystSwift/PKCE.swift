// Licensed under the MIT License
//
// Copyright (c) 2024 Jiro Matsuzawa
// Copyright (c) 2025 Natsune Mochizuki
// ref: https://qiita.com/jmatsuzawa/items/b870ccb3e2d566c91422

import CryptoKit
import Foundation

public enum PKCEError: Error {
    case RandomGenerationFailed
}

public struct PKCE {
    let verifier: String
    let challenge: String
    let method = "S256"
    
    public init() throws {
        self.verifier = try Self.getVerifier()
        self.challenge = Self.computeChallenge(of: self.verifier)
    }
    
    private static func getVerifier() throws -> String {
        return try getRandomBase64EncodedString(count: 32)
    }
    
    private static func getRandomBase64EncodedString(count: Int) throws -> String {
        var bytes = [UInt8](repeating: 0, count: count)
        let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        guard status == errSecSuccess else {
            throw PKCEError.RandomGenerationFailed
        }
        
        return base64Encode(bytes)
    }
    
    private static func base64Encode(_ bytes: [UInt8]) -> String {
        return Data(bytes).base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
    
    private static func computeChallenge(of verifier: String) -> String {
        let digest = SHA256.hash(data: Data(verifier.utf8))
        return base64Encode(Array(digest))
    }
}
