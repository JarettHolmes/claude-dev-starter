# API Project - Domain Translation Snippets

## Concept Mappings

| When You Think | We Actually Use | Gotcha |
|----------------|----------------|--------|
| "GraphQL resolver" | Apollo Server resolvers in src/resolvers/ | Use dataloaders to prevent N+1 queries |
| "Database query" | Prisma client with TypeScript types | Always use transactions for multi-step operations |
| "Authentication" | JWT tokens with RS256 signing | Keys in environment variables only, never HS256 |
| "Authorization" | Context + role-based middleware | Check permissions before resolver execution |
| "Validation" | Yup schemas in src/validation/ | Validate input before business logic |
| "Error handling" | Custom GraphQL errors with codes | Use apollo-errors for structured error responses |
| "Testing" | Jest with apollo-server-testing | Test resolvers in isolation, mock data sources |
| "Database migration" | Prisma Migrate in migrations/ | Always create migration before changing schema |
| "Caching" | Redis with apollo-cache-control | Set maxAge for cacheable queries |
| "API documentation" | GraphQL schema + docstrings | Document all fields and arguments |

## Tool Selection Matrix

| IF (Condition) | USE (Tool/Approach) | WHY (Reasoning) |
|----------------|---------------------|-----------------|
| Need to prevent N+1 queries | DataLoader with batching | Batches multiple queries into single database call |
| Need to validate input | Yup schema before resolver | Consistent validation, clear error messages |
| Need to handle errors | apollo-errors package | Structured errors with codes (UNAUTHENTICATED, etc.) |
| Need to cache responses | Redis + apollo-cache-control | Fast reads, reduces database load |
| Need background jobs | BullMQ with Redis | Reliable job queue, retries, scheduling |

## Quick Reference Patterns

### GraphQL Resolver with DataLoader
```typescript
// Create DataLoader
const userLoader = new DataLoader(async (ids: number[]) => {
  const users = await prisma.user.findMany({
    where: { id: { in: ids } }
  })
  return ids.map(id => users.find(u => u.id === id))
})

// Use in resolver
const resolvers = {
  Query: {
    posts: async (_, __, { dataloaders }) => {
      const posts = await prisma.post.findMany()
      // Load users in batch, not one-by-one
      const users = await Promise.all(
        posts.map(post => dataloaders.user.load(post.userId))
      )
      return posts.map((post, i) => ({ ...post, user: users[i] }))
    }
  }
}
```

### Input Validation with Yup
```typescript
import * as yup from 'yup'

const createUserSchema = yup.object({
  email: yup.string().email().required(),
  password: yup.string().min(8).required(),
  role: yup.string().oneOf(['USER', 'ADMIN']).required()
})

const resolvers = {
  Mutation: {
    createUser: async (_, { input }, context) => {
      // Validate first
      await createUserSchema.validate(input)
      // Then execute
      return prisma.user.create({ data: input })
    }
  }
}
```

### JWT Authentication
```typescript
import jwt from 'jsonwebtoken'

// Generate token (RS256)
const token = jwt.sign(
  { userId: user.id, role: user.role },
  process.env.JWT_PRIVATE_KEY,
  { algorithm: 'RS256', expiresIn: '7d' }
)

// Verify token (in context)
const context = ({ req }) => {
  const token = req.headers.authorization?.replace('Bearer ', '')
  if (!token) return { user: null }

  try {
    const decoded = jwt.verify(token, process.env.JWT_PUBLIC_KEY, {
      algorithms: ['RS256']
    })
    return { user: decoded }
  } catch {
    return { user: null }
  }
}
```

## Common Anti-Patterns

❌ **Direct database queries in resolvers (N+1 problem)**
```typescript
// Wrong
const posts = await prisma.post.findMany()
for (const post of posts) {
  post.user = await prisma.user.findUnique({ where: { id: post.userId } })
}

// Right
const posts = await prisma.post.findMany({ include: { user: true } })
// Or use DataLoader for flexibility
```

❌ **Using HS256 for JWT signing**
```typescript
// Wrong - symmetric key, less secure
jwt.sign(payload, 'secret', { algorithm: 'HS256' })

// Right - asymmetric key, more secure
jwt.sign(payload, privateKey, { algorithm: 'RS256' })
```

❌ **No input validation before business logic**
```typescript
// Wrong
createUser: async (_, { input }) => {
  return prisma.user.create({ data: input })  // No validation
}

// Right
createUser: async (_, { input }) => {
  await userSchema.validate(input)
  return prisma.user.create({ data: input })
}
```

❌ **Inline error handling without codes**
```typescript
// Wrong
throw new Error('User not found')

// Right
import { ApolloError } from 'apollo-errors'
throw new ApolloError('User not found', 'USER_NOT_FOUND')
```

❌ **Missing database transactions for multi-step operations**
```typescript
// Wrong - no transaction, can fail midway
await prisma.user.create(...)
await prisma.profile.create(...)

// Right - atomic transaction
await prisma.$transaction(async (tx) => {
  await tx.user.create(...)
  await tx.profile.create(...)
})
```
