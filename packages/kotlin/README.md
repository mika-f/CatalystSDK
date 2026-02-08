# CatalystKotlin

Official Catalyst Kotlin SDK for JVM platforms.

## Features

- 🚀 Modern Kotlin design with Coroutines support
- 💪 Type-safe API with comprehensive data models
- 🔐 Built-in OAuth 2.0 with PKCE authentication
- 📦 Kotlinx.serialization for JSON handling
- 🌐 Ktor Client for HTTP operations
- ♻️ Automatic token refresh support

## Installation

### Gradle Kotlin DSL

```kotlin
dependencies {
    implementation("com.natsuneko.catalyst:catalyst-kotlin:0.1.0")
}
```

### Gradle Groovy

```groovy
dependencies {
    implementation 'com.natsuneko.catalyst:catalyst-kotlin:0.1.0'
}
```

### Maven

```xml
<dependency>
    <groupId>com.natsuneko.catalyst</groupId>
    <artifactId>catalyst-kotlin</artifactId>
    <version>0.1.0</version>
</dependency>
```

## Quick Start

### Basic Usage

```kotlin
import com.natsuneko.catalyst.CatalystKotlin
import com.natsuneko.catalyst.auth.Pkce
import kotlinx.coroutines.runBlocking

fun main() = runBlocking {
    // Create client
    val client = CatalystKotlin(
        clientId = "your-client-id",
        clientSecret = "your-client-secret"
    )

    // OAuth authentication
    val pkce = Pkce()
    val state = "random-state-string"
    val redirectUri = "your-app://callback"

    // Get authorization URL
    val authUrl = client.oauth.getAuthorizeUrl(redirectUri, pkce, state)
    println("Please visit: $authUrl")

    // After user authorization, exchange code for token
    val code = "authorization-code-from-callback"
    val token = client.oauth.getAccessTokenByCode(code, redirectUri, pkce)

    // Set credentials
    client.setCredentials(token)

    // Now you can make API calls
    val user = client.egeria.getCurrentUser()
    println("Authenticated as: ${user?.displayName}")

    // Get home timeline
    val timeline = client.catalyst.getHomeTimeline()
    timeline.forEach { status ->
        println("${status.user?.displayName}: ${status.body}")
    }

    // Post a status
    val newStatus = client.catalyst.createStatus(
        body = "Hello from CatalystKotlin!",
        privacy = CatalystStatusPrivacy.PUBLIC
    )
    println("Posted status: ${newStatus.id}")

    // Don't forget to close the client
    client.close()
}
```

### Using Existing Tokens

```kotlin
val client = CatalystKotlin(
    clientId = "your-client-id",
    clientSecret = "your-client-secret",
    accessToken = "existing-access-token",
    refreshToken = "existing-refresh-token"
)
```

### Refresh Token

```kotlin
// Manually refresh the token
val newToken = client.refresh()
println("New access token: ${newToken.accessToken}")
```

## API Clients

The SDK provides four main API clients:

### 1. Catalyst Client

Handles statuses, albums, timelines, and reactions.

```kotlin
// Create a status
client.catalyst.createStatus(
    body = "Hello, World!",
    privacy = CatalystStatusPrivacy.PUBLIC,
    mediaIds = listOf("media-id-1", "media-id-2")
)

// Get home timeline
val timeline = client.catalyst.getHomeTimeline(since = "2025-01-01", until = "2025-12-31")

// Create an album
val album = client.catalyst.createAlbum(
    name = "My Album",
    description = "A collection of my favorite posts",
    isPublic = true,
    mode = CatalystAlbumDisplayMode.GRID
)

// React to a status
client.catalyst.react(statusId = "status-id", symbol = "👍")
```

### 2. Egeria Client

Handles user management and profile operations.

```kotlin
// Get current user
val currentUser = client.egeria.getCurrentUser()

// Update profile
client.egeria.updateProfile(
    bio = "New bio",
    website = "https://example.com"
)

// Search users
val users = client.egeria.searchUsers("keyword")

// Get user by username
val user = client.egeria.getUserByUsername("username")
```

### 3. Media Client

Handles media upload and download operations.

```kotlin
// Get upload URL
val uploadUrls = client.media.getUploadUrl()
println("Upload to: ${uploadUrls.signedUrl}")

// Download media
val mediaBytes = client.media.download("https://example.com/media.jpg")

// Delete media
client.media.delete("media-id")
```

### 4. Steambird Client

Handles notification operations.

```kotlin
import com.natsuneko.catalyst.clients.SteambirdClient

// Get notifications
val notifications = client.steambird.getNotifications(
    issuer = SteambirdClient.ISSUER_CATALYST_SYSTEM_MESSAGE
)

// Mark notification as read
client.steambird.markAsRead("notification-id")

// Get unread count
val unreadCount = client.steambird.getUnreadCount()
println("Unread notifications: ${unreadCount.count}")
```

## Advanced Usage

### Custom HTTP Client Configuration

```kotlin
val client = CatalystKotlin(
    clientId = "your-client-id",
    clientSecret = "your-client-secret"
)

// The SDK uses Ktor Client internally
// You can customize it through the CatalystHttpClient if needed
```

### JSON Decoding

```kotlin
// Decode webhook payloads or other JSON data
val status = CatalystKotlin.decode<CatalystStatus>(jsonString)
```

### Error Handling

```kotlin
import io.ktor.client.plugins.*

try {
    val status = client.catalyst.getStatus("invalid-id")
} catch (e: ClientRequestException) {
    // Handle 4xx errors
    println("Client error: ${e.response.status}")
} catch (e: ServerResponseException) {
    // Handle 5xx errors
    println("Server error: ${e.response.status}")
} catch (e: Exception) {
    // Handle other errors
    println("Error: ${e.message}")
}
```

## Requirements

- Java 17 or later
- Kotlin 2.1.0 or later

## License

MIT by [@6jz](https://twitter.com/6jz)
