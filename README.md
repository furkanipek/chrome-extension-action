# Chrome Extension Upload & Publish

This action uses Chrome Web Store API to uploads and publishes to given publishTarget the zipped file which you provide via getting access token by provided refresh token.

## Using the Chrome Web Store Publish API

Chrome Web Store API Getting Started : https://developer.chrome.com/docs/webstore/using_webstore_api/

Chrome Web Store API : https://console.cloud.google.com/apis/api/chromewebstore.googleapis.com

Chrome Web Store API Reference : https://developer.chrome.com/docs/webstore/api_index/

## Inputs

### `refresh-token`
Your Google OAuth2 refresh token

### `extension-id`
Your Google Extension id

### `client-id`
Your Google OAuth2 Client ID

### `client-secret`
Your Google OAuth2 Client Secret

### `extension-file`
Zipped file version of the extension

### `publish`
Should it be published after the upload? True or False

### `tester`
Release only for trusted test users. True or False


## Example usage

```
uses: furkanipek/chrome-extension-action@$VERSION
with:
  refresh-token: 'xxxxxxxxxxxx'
  extension-id: 'xxxxxxxxxxx'
  client-id: 'xxxxxxxx'
  client-secret: 'xxxxxxxxxxxx'
  extension-file: 'xxxxxxxxx-xxxx'
  publish: true
  tester: false
```