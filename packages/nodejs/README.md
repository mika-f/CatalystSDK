# CatalystTS

Official Catalyst SDK for TypeScript / JavaScript / Node.js, built for both browser and server environments.

## Installation

```bash
$ npm install @natsuneko-laboratory/catalyst-sdk --save
```

## Usage

```typescript
// authentication
import { CatalystTS, PKCE } from "@natsuneko-laboratory/catalyst-sdk";
import { v4 } from "uuid";

const API_KEY = {
  clientId: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  clientSecret: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  redirectUri: "https://example.com/callback",
};

const client = new CatalystTS({
  clientId: API_KEY.clientId,
  clientSecret: API_KEY.clientSecret,
  accessToken: "",
  refreshToken: "",
});
const pkce = await PKCE.create();
const state = v4();
const redirect = client.oauth.getAuthorizeURL(API_KEY.redirectUri, pkce, state);

// redirected to `redirectUri`
const searchParams = new URLSearchParams(window.location.search);
const code = searchParams.get("code");
const returnedState = searchParams.get("state");

if (code && returnedState === state) {
  const { accessToken, refreshToken } = await client.oauth.getAccessTokenByCode(
    code,
    API_KEY.redirectUri,
    pkce,
  );

  console.log("accessToken:", accessToken);
  console.log("refreshToken:", refreshToken);
}

// call user specified APIs
const me = await client.egeria.me();
console.log({ me });
```

## License

MIT by [@6jz](https://twitter.com/6jz)
