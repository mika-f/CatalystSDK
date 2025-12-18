// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki
import Foundation

final class UserAgentInterceptor: RequestInterceptor {
  private let agent: String

  init() {
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    let os = ProcessInfo.processInfo.operatingSystemVersionString

    self.agent = "CatalystSwift/\(version) (\(build)); OS \(os)"
  }

  func adapt(_ request: URLRequest) async throws -> URLRequest {
    var request = request
    request.setValue(agent, forHTTPHeaderField: "User-Agent")

    return request
  }

  func retry(_ request: URLRequest, with error: any Error) async throws -> Bool {
    return false
  }
}
