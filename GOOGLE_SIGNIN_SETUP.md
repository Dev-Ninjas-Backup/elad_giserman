# Google Sign-In Setup Instructions

This project has been configured to support Google Sign-In authentication. To fully enable this feature, you need to complete the platform-specific setup.

## Prerequisites

1. Create a project in the [Google Cloud Console](https://console.cloud.google.com/)
2. Enable the Google Sign-In API
3. Create OAuth 2.0 credentials for your application

## Android Setup

### 1. Get SHA-1 Certificate Fingerprint

```bash
# For debug builds
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore

# For release builds (if you have a release keystore)
keytool -list -v -alias your_key_alias -keystore path/to/your/keystore
```

### 2. Configure OAuth 2.0 Client

1. In Google Cloud Console, go to "Credentials"
2. Create OAuth 2.0 Client ID for Android
3. Add your package name: `com.yamiz.elad_giserman` 
4. Add your SHA-1 certificate fingerprint

### 3. Download google-services.json

1. Download the `google-services.json` file from Firebase Console or Google Cloud Console
2. Place it in `android/app/google-services.json`

### 4. Update build.gradle

Add to `android/build.gradle` (project level):
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.4.0'
}
```

Add to `android/app/build.gradle` (app level):
```gradle
plugins {
    id 'com.google.gms.google-services'
}
```

## iOS Setup

### 1. Configure OAuth 2.0 Client

1. In Google Cloud Console, create OAuth 2.0 Client ID for iOS
2. Add your bundle identifier: `com.yamiz.eladGiserman`

### 2. Update Info.plist

Add to `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>REVERSED_CLIENT_ID</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

Replace `YOUR_REVERSED_CLIENT_ID` with the reversed client ID from your OAuth 2.0 credentials.

### 3. Download GoogleService-Info.plist

1. Download the `GoogleService-Info.plist` file
2. Add it to your iOS project in Xcode (Runner target)

## Web Setup (Optional)

If you plan to support web, add your domain to the authorized origins in your OAuth 2.0 credentials.

## Testing

After completing the setup:

1. Run `flutter clean`
2. Run `flutter pub get`
3. Build and test the application

The Google Sign-In buttons should now work properly in both login and signup screens.

## API Integration

The app is configured to send the Google ID token to:
- **Endpoint**: `POST /api/auth/google-login`
- **Request Body**: 
```json
{
  "idToken": "google_id_token_here"
}
```

Your backend should verify the ID token with Google and return user data in the same format as regular login.

## Troubleshooting

- **DEVELOPER_ERROR**: Usually means `google-services.json` is missing or OAuth client is not properly configured
- **INTERNAL_ERROR**: Check if the SHA-1 fingerprint matches your debug/release keystore
- **Network errors**: Verify the backend endpoint is accessible and returns proper response format