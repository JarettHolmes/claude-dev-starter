# Web App - Domain Translation Snippets

Use these as starting points for your Translation Guide.

## Concept Mappings

| When You Think | We Actually Use | Gotcha |
|----------------|----------------|--------|
| "Database query" | Prisma ORM with TypeScript types | Always use `include` for relations to avoid N+1 queries |
| "State management" | Zustand stores in src/stores/ | Don't use Redux, context, or component state for global data |
| "API call" | tRPC procedures with automatic type safety | Never use fetch() for internal APIs - tRPC provides end-to-end types |
| "Component" | React component in src/components/ with .tsx extension | Use functional components with hooks, no class components |
| "Styling" | Tailwind utility classes, no CSS modules | Use design tokens from tailwind.config.js for consistency |
| "Routing" | React Router v6 with route definitions in src/routes.tsx | Use loaders for data fetching, not useEffect |
| "Form validation" | Zod schemas in src/schemas/ | Define schema first, derive TypeScript types with z.infer |
| "Authentication" | NextAuth.js with JWT strategy | Session stored in httpOnly cookie, never localStorage |
| "Environment vars" | .env.local (never commit), access via import.meta.env | Prefix with VITE_ for client-side variables |
| "Build output" | dist/ folder created by Vite | Run `npm run build` before deployment |

## Tool Selection Matrix

| IF (Condition) | USE (Tool/Approach) | WHY (Reasoning) |
|----------------|---------------------|-----------------|
| Need to persist data client-side | localStorage for <5KB, IndexedDB for >5KB | IndexedDB is async, better performance for large data |
| Need to style component | Tailwind utility classes first | Consistency with design system, easier maintenance |
| Need to fetch external API | React Query + axios | Handles caching, retries, loading/error states automatically |
| Need global state | Zustand store | Simpler than Redux, better performance than Context |
| Need form handling | React Hook Form + Zod | Performant (uncontrolled), type-safe validation |

## Quick Reference Patterns

### Database Query Example
```typescript
// Fetch users with relations (Prisma)
const users = await prisma.user.findMany({
  where: { active: true },
  include: {
    posts: true,     // Include related posts
    profile: true    // Include profile
  },
  orderBy: { createdAt: 'desc' }
})
```

**When**: Querying database with Prisma
**Why**: Using `include` prevents N+1 query problem

### API Call Example (tRPC)
```typescript
// Client-side tRPC call
import { trpc } from '@/utils/trpc'

function UserList() {
  const { data, isLoading } = trpc.users.getAll.useQuery()

  if (isLoading) return <div>Loading...</div>
  return <div>{data.map(user => ...)}</div>
}
```

**When**: Calling backend API from frontend
**Why**: End-to-end type safety, no need for manual fetch() or axios

### Zustand Store Example
```typescript
// src/stores/authStore.ts
import { create } from 'zustand'

interface AuthState {
  user: User | null
  setUser: (user: User | null) => void
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  setUser: (user) => set({ user })
}))

// Usage in component
const user = useAuthStore((state) => state.user)
const setUser = useAuthStore((state) => state.setUser)
```

**When**: Need global state accessible across components
**Why**: Simple API, no providers needed, automatic re-renders

### Form with Validation Example
```typescript
// Define Zod schema
const userSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  age: z.number().min(18)
})

type UserForm = z.infer<typeof userSchema>

// Use in React Hook Form
function RegisterForm() {
  const { register, handleSubmit, formState: { errors } } = useForm<UserForm>({
    resolver: zodResolver(userSchema)
  })

  const onSubmit = (data: UserForm) => {
    // data is type-safe and validated
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      {errors.email && <span>{errors.email.message}</span>}
    </form>
  )
}
```

**When**: Building forms with validation
**Why**: Type-safe, reusable schema, automatic error handling

## Common Anti-Patterns

❌ **Using fetch() for internal API calls**
- **Why wrong**: No type safety, manual error handling, no caching
- **Correct approach**: Use tRPC procedures for end-to-end type safety
- **Example**:
```typescript
// Wrong
const response = await fetch('/api/users')
const data = await response.json()  // No type safety

// Right
const data = await trpc.users.getAll.query()  // Fully typed
```

✅ **Correct Pattern**: Always use tRPC for internal APIs, only use fetch() for external APIs

---

❌ **Inline Tailwind classes without design system**
- **Why wrong**: Inconsistent styling, magic numbers, hard to maintain
- **Correct approach**: Use design tokens from tailwind.config.js
- **Example**:
```tsx
// Wrong
<div className="p-4 bg-blue-500 text-white rounded-lg">

// Right
<div className="p-card bg-primary text-primary-foreground rounded-card">
```

✅ **Correct Pattern**: Define tokens in tailwind.config.js, use semantic class names

---

❌ **Using component state for global data**
- **Why wrong**: Prop drilling, re-renders, hard to share between components
- **Correct approach**: Use Zustand for global state
- **Example**:
```typescript
// Wrong
function App() {
  const [user, setUser] = useState(null)
  return <Header user={user} setUser={setUser} />  // Prop drilling
}

// Right
const user = useAuthStore((state) => state.user)  // Accessible anywhere
```

✅ **Correct Pattern**: Global state in Zustand, local UI state in useState

---

❌ **Fetching data in useEffect**
- **Why wrong**: Race conditions, no caching, manual loading states
- **Correct approach**: Use React Query or tRPC query hooks
- **Example**:
```typescript
// Wrong
useEffect(() => {
  fetch('/api/users').then(res => res.json()).then(setUsers)
}, [])

// Right
const { data: users } = trpc.users.getAll.useQuery()
```

✅ **Correct Pattern**: Use query hooks, they handle caching and loading states

---

❌ **N+1 queries with Prisma**
- **Why wrong**: Performance issue - one query per relation
- **Correct approach**: Use `include` or `select` to fetch relations in single query
- **Example**:
```typescript
// Wrong - N+1 problem
const users = await prisma.user.findMany()
for (const user of users) {
  user.posts = await prisma.post.findMany({ where: { userId: user.id } })
}

// Right - Single query
const users = await prisma.user.findMany({
  include: { posts: true }
})
```

✅ **Correct Pattern**: Always use `include` for relations, never separate queries
