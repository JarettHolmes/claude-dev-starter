# API Project - Capability Limits Snippets

## Documented Limits

### Prisma Connection Pool

- **Issue**: Connection pool exhaustion under high concurrent load
- **Threshold**: Default 10 connections, exhausts at ~100 concurrent requests
- **Workaround**: Increase pool size in DATABASE_URL or use connection pooler (PgBouncer)
- **Tested**: 2024-11, load test with 200 concurrent requests, 100% reproducible
- **Workaround Reference**:
```typescript
// In schema.prisma or DATABASE_URL
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
  connectionLimit = 20  // Increase from default 10
}
```

### GraphQL Query Depth

- **Issue**: Deeply nested queries can cause performance issues
- **Threshold**: >10 levels of nesting causes slow responses (>2 seconds)
- **Workaround**: Use graphql-depth-limit plugin to restrict depth
- **Tested**: 2024-10, nested queries at varying depths, performance degrades after depth 10
- **Workaround Reference**:
```typescript
import depthLimit from 'graphql-depth-limit'

const server = new ApolloServer({
  validationRules: [depthLimit(10)]
})
```

### JWT Token Size

- **Issue**: Large JWT tokens (>8KB) may exceed header size limits
- **Threshold**: ~8KB (nginx default header size)
- **Workaround**: Keep JWT payload minimal, store additional data in database
- **Tested**: 2024-09, tokens with varying claim sizes, header rejection at ~8KB
- **Workaround Reference**:
```typescript
// Wrong - too much in token
const token = jwt.sign({
  userId, role, permissions: [...100 items], metadata: {...}
}, key)

// Right - minimal token
const token = jwt.sign({ userId, role }, key)
// Fetch additional data from database when needed
```

## Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| Redis memory | May have limits on cached response size | Cache varying response sizes, monitor memory usage | HIGH |
| Rate limiting | Need to determine optimal rate limits per endpoint | Load test with varying request rates | HIGH |
| File upload size | GraphQL may have limits on upload size | Upload files of varying sizes | MEDIUM |
| Subscription scalability | WebSocket connections may have concurrency limits | Test with varying number of concurrent subscriptions | MEDIUM |
| Database query complexity | Complex joins may timeout | Create increasingly complex queries, measure performance | LOW |
