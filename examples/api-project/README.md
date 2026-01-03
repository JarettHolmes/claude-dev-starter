# API Project Example

This example shows how to customize the AI guides for a **GraphQL/REST API backend**.

## Technology Stack

- **API**: Apollo Server (GraphQL)
- **Database**: PostgreSQL with Prisma ORM
- **Auth**: JWT with RS256 signing
- **Validation**: Yup schemas
- **Caching**: Redis
- **Background Jobs**: BullMQ
- **Testing**: Jest
- **Error Handling**: apollo-errors

## What's Included

**10 concept mappings**:
1. GraphQL resolver → Apollo Server
2. Database query → Prisma client
3. Authentication → JWT RS256
4. Authorization → Role-based middleware
5. Validation → Yup schemas
6. Error handling → Custom GraphQL errors
7. Testing → Jest + apollo-server-testing
8. Database migration → Prisma Migrate
9. Caching → Redis
10. API documentation → GraphQL schema + docstrings

**5 anti-patterns**:
1. ❌ N+1 queries in resolvers
2. ❌ Using HS256 for JWT
3. ❌ No input validation
4. ❌ Inline error handling without codes
5. ❌ Missing database transactions

**3 quick reference patterns**:
- Resolver with DataLoader (N+1 prevention)
- Input validation with Yup
- JWT authentication

## How to Use

Same process as web-app example:
1. Copy snippets to your guides
2. Replace tools if using different stack (e.g., REST instead of GraphQL)
3. Add your patterns
4. Validate

**For REST APIs**, replace GraphQL-specific patterns:
```markdown
| "API endpoint" | Express router in src/routes/ | Use middleware for auth, validation |
| "Response format" | JSON with envelope pattern | Always return { data, error, meta } |
```

## Expansion Ideas

Add mappings for:
- **Deployment**: Docker, Kubernetes, AWS
- **Monitoring**: DataDog, New Relic
- **Rate limiting**: express-rate-limit, Redis
- **WebSockets**: GraphQL subscriptions
- **File uploads**: Multipart form data handling
