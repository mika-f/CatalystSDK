// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum CatalystStatusPrivacy: String, Codable, Sendable, Equatable, Hashable {
  case global = "public"
  case quiet_public
  case followers
  case hidden = "private"
}
