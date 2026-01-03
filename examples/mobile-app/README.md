# Mobile App Example

This example shows how to customize the AI guides for a **React Native mobile application**.

## Technology Stack

- **Framework**: React Native + Expo
- **Navigation**: React Navigation v6
- **Storage**: AsyncStorage (small data), SQLite (large data)
- **State Management**: Zustand
- **API**: Axios with interceptors
- **Device Features**: Expo SDK (Camera, Location, Notifications, Image)
- **Forms**: React Hook Form
- **Animations**: React Native Reanimated
- **Build**: EAS Build

## What's Included

**10 concept mappings**:
1. Navigation → React Navigation v6
2. Local storage → AsyncStorage
3. API call → Axios with interceptors
4. Styling → StyleSheet.create()
5. State → Zustand
6. Images → Expo Image
7. Push notifications → Expo Notifications
8. Camera → Expo Camera
9. Location → Expo Location
10. Build → EAS Build

**5 anti-patterns**:
1. ❌ Using localStorage (doesn't exist)
2. ❌ Using expo-router (we use React Navigation)
3. ❌ fetch() without timeout
4. ❌ Inline styles
5. ❌ Direct device access without permissions

**4 quick reference patterns**:
- Navigation setup and usage
- AsyncStorage operations
- API call with auth interceptor
- StyleSheet usage

## How to Use

Same process as other examples:
1. Copy snippets to guides
2. Customize for your stack (e.g., if using TypeScript navigation types)
3. Add mobile-specific patterns (offline sync, deep linking, etc.)
4. Validate

## Expansion Ideas

Add mappings for:
- **Deep linking**: Expo Linking, URL schemes
- **Offline sync**: Redux Persist, WatermelonDB
- **Push notifications**: Token registration, handling
- **App updates**: OTA with Expo Updates
- **Analytics**: Segment, Amplitude
- **Error tracking**: Sentry for React Native
