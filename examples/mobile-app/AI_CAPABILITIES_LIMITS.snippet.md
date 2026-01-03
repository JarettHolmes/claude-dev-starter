# Mobile App - Capability Limits Snippets

## Documented Limits

### AsyncStorage Size Limit

- **Issue**: AsyncStorage has platform-specific size limits
- **Threshold**: iOS ~10MB, Android ~6MB (varies by device)
- **Workaround**: Use SQLite (expo-sqlite) for larger datasets
- **Tested**: 2024-11, tested on 5 iOS and 5 Android devices
- **Workaround Reference**:
```typescript
// Switch to SQLite for large data
import * as SQLite from 'expo-sqlite'
const db = SQLite.openDatabase('mydb.db')
```

### Image Memory Usage

- **Issue**: Large images can cause out-of-memory crashes
- **Threshold**: Images >5MB on lower-end Android devices
- **Workaround**: Resize images before loading, use Expo Image component
- **Tested**: 2024-10, tested with varying image sizes on low-end devices
- **Workaround Reference**:
```typescript
import { Image } from 'expo-image'

// Expo Image handles caching and memory better
<Image
  source={{ uri: imageUrl }}
  contentFit="cover"
  cachePolicy="memory-disk"
/>
```

### Network Request Timeout

- **Issue**: Slow networks can cause requests to hang indefinitely
- **Threshold**: No default timeout in fetch()
- **Workaround**: Always set timeout with axios
- **Tested**: 2024-09, simulated slow networks, fetch() hangs forever
- **Workaround Reference**:
```typescript
const api = axios.create({
  baseURL: API_URL,
  timeout: 10000  // 10 seconds
})
```

## Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| Battery usage | Background location tracking may drain battery quickly | Monitor battery usage with location services enabled | HIGH |
| App size | Too many images/assets may exceed App Store limits | Measure app bundle size, test compression | MEDIUM |
| Offline sync | May have limits on offline queue size | Test with varying amounts of offline data | HIGH |
| Reanimated performance | Complex animations may drop frames on older devices | Test animations on low-end devices | MEDIUM |
| Push notification delivery | May have delays or failures in certain conditions | Test across different network conditions | LOW |
