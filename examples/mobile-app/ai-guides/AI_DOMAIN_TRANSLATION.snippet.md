# Mobile App - Domain Translation Snippets

## Concept Mappings

| When You Think | We Actually Use | Gotcha |
|----------------|----------------|--------|
| "Navigation" | React Navigation v6 stack navigator in src/navigation/ | Don't use expo-router, we standardized on React Navigation |
| "Local storage" | AsyncStorage from @react-native-async-storage | Never use localStorage (doesn't exist in React Native) |
| "API call" | Axios with request interceptors in src/api/ | Use interceptors for auth token injection |
| "Styling" | StyleSheet.create() not inline styles | Better performance with StyleSheet |
| "State management" | Zustand stores in src/stores/ | Simpler than Redux, works great with RN |
| "Image handling" | Expo Image component | Better caching and performance than <Image> |
| "Push notifications" | Expo Notifications | Handles permissions and token management |
| "Camera" | Expo Camera | Handles permissions automatically |
| "Location" | Expo Location | Request permissions before accessing |
| "Build" | EAS Build for iOS and Android | Don't use Expo build (deprecated) |

## Tool Selection Matrix

| IF (Condition) | USE (Tool/Approach) | WHY (Reasoning) |
|----------------|---------------------|-----------------|
| Need persistent storage | AsyncStorage for <5MB, SQLite for >5MB | AsyncStorage async, good for key-value pairs |
| Need device features | Expo SDK libraries first | Handles permissions, cross-platform |
| Need navigation | React Navigation stack/tabs/drawer | Most flexible, widely supported |
| Need forms | React Hook Form (uncontrolled) | Better performance than controlled inputs |
| Need animations | React Native Reanimated | Runs on UI thread, smoother than Animated API |

## Quick Reference Patterns

### Navigation Setup
```typescript
// src/navigation/AppNavigator.tsx
import { createStackNavigator } from '@react-navigation/stack'

const Stack = createStackNavigator()

export function AppNavigator() {
  return (
    <Stack.Navigator initialRouteName="Home">
      <Stack.Screen name="Home" component={HomeScreen} />
      <Stack.Screen name="Profile" component={ProfileScreen} />
    </Stack.Navigator>
  )
}

// Navigate from component
import { useNavigation } from '@react-navigation/native'

function HomeScreen() {
  const navigation = useNavigation()
  return (
    <Button onPress={() => navigation.navigate('Profile')} />
  )
}
```

### AsyncStorage Usage
```typescript
import AsyncStorage from '@react-native-async-storage/async-storage'

// Store data
await AsyncStorage.setItem('@user_token', token)

// Retrieve data
const token = await AsyncStorage.getItem('@user_token')

// Remove data
await AsyncStorage.removeItem('@user_token')

// Store object (stringify first)
await AsyncStorage.setItem('@user', JSON.stringify(user))
const user = JSON.parse(await AsyncStorage.getItem('@user'))
```

### API Call with Auth Interceptor
```typescript
import axios from 'axios'
import AsyncStorage from '@react-native-async-storage/async-storage'

const api = axios.create({
  baseURL: 'https://api.example.com',
  timeout: 10000
})

// Inject auth token
api.interceptors.request.use(async (config) => {
  const token = await AsyncStorage.getItem('@auth_token')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

// Usage
const response = await api.get('/users')
```

### StyleSheet Usage
```typescript
import { View, Text, StyleSheet } from 'react-native'

function MyComponent() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Hello</Text>
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: '#fff'
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold'
  }
})
```

## Common Anti-Patterns

❌ **Using localStorage (doesn't exist in React Native)**
```typescript
// Wrong
localStorage.setItem('token', token)

// Right
import AsyncStorage from '@react-native-async-storage/async-storage'
await AsyncStorage.setItem('@token', token)
```

❌ **Using expo-router (we use React Navigation)**
```typescript
// Wrong
import { Link } from 'expo-router'

// Right
import { useNavigation } from '@react-navigation/native'
const navigation = useNavigation()
navigation.navigate('Screen')
```

❌ **Using fetch() without timeout**
```typescript
// Wrong - no timeout, can hang forever
const response = await fetch('https://api.example.com/users')

// Right - use axios with timeout
const api = axios.create({ timeout: 10000 })
const response = await api.get('/users')
```

❌ **Inline styles instead of StyleSheet**
```typescript
// Wrong - bad performance
<View style={{ padding: 16, backgroundColor: '#fff' }}>

// Right - better performance
<View style={styles.container}>

const styles = StyleSheet.create({
  container: { padding: 16, backgroundColor: '#fff' }
})
```

❌ **Direct camera/location access without permission check**
```typescript
// Wrong - crashes if permission denied
const { status } = await Camera.requestCameraPermissionsAsync()
const photo = await camera.takePictureAsync()

// Right - check permission first
const { status } = await Camera.requestCameraPermissionsAsync()
if (status === 'granted') {
  const photo = await camera.takePictureAsync()
}
```
