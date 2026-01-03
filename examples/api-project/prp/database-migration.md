name: "Database Migration: SQLite to PostgreSQL"
description: |
  Transform: Migrate application database from SQLite to PostgreSQL with zero downtime
  and complete data preservation.

---

## Goal

Migrate the application database from SQLite to PostgreSQL while maintaining 100% data integrity, ensuring zero downtime during production deployment, and improving query performance for complex joins.

## Why

**For production**: PostgreSQL offers better concurrency, JSONB support, and production-grade features
**For developers**: Advanced query capabilities, better type system, and robust tooling
**For scalability**: Connection pooling, read replicas, and horizontal scaling options

## What

### Transformation Spec

**Current State**:
- Database: SQLite (`app.db`)
- Location: Local file in project root
- Size: ~500MB, 12 tables, ~100K rows
- Schema: Prisma ORM with auto-generated migrations
- Queries: Mix of simple lookups and complex joins

**Desired State**:
- Database: PostgreSQL 15+
- Location: Cloud-hosted (RDS/Supabase/Railway)
- Schema: Identical structure with PostgreSQL-specific optimizations
- Data: 100% migrated with integrity verification
- Performance: <100ms for 95th percentile queries

**Constraints**:
- **Zero downtime**: Use blue-green deployment
- **Data integrity**: Verify every row with checksums
- **Rollback plan**: Keep SQLite as backup for 7 days
- **Testing**: Full QA cycle before production

### Success Criteria

- [ ] PostgreSQL database provisioned and configured
- [ ] Schema migrated with proper indexes and constraints
- [ ] All data migrated (verified row counts match)
- [ ] Data integrity verified (checksums match)
- [ ] Application connects to PostgreSQL successfully
- [ ] All queries return correct results (compared to SQLite)
- [ ] Performance meets SLA (<100ms p95)
- [ ] Rollback procedure tested and documented
- [ ] SQLite backup maintained for 7 days

## All Needed Context

### Documentation & References

```yaml
# Project Patterns (from AI_DOMAIN_TRANSLATION_GUIDE.md)
- Database: Currently SQLite, migrating to PostgreSQL with Prisma
  Pattern: Use Prisma Migrate for schema changes
  Example: npx prisma migrate dev --name add-field

- API Layer: GraphQL with Apollo Server
  Pattern: Resolvers use Prisma client
  Gotcha: Connection pooling needed for PostgreSQL

- Environment Config: dotenv for connection strings
  Pattern: DATABASE_URL in .env
  Location: .env.local (dev), .env.production (prod)

- Testing: Jest with Prisma mock
  Pattern: Use separate test database
  Gotcha: Reset database between tests
```

### Current Codebase State

```typescript
// prisma/schema.prisma (Current)
datasource db {
  provider = "sqlite"
  url      = "file:./app.db"
}

generator client {
  provider = "prisma-client-js"
}

model User {
  id        Int      @id @default(autoincrement())
  email     String   @unique
  createdAt DateTime @default(now())
  posts     Post[]
}

model Post {
  id        Int      @id @default(autoincrement())
  title     String
  content   String
  userId    Int
  user      User     @relation(fields: [userId], references: [id])
}

// ... 10 more models
```

```typescript
// Server configuration
// src/server.ts
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()  // Direct connection, no pooling
```

### Desired Codebase State

```prisma
// prisma/schema.prisma (PostgreSQL)
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
  previewFeatures = ["postgresqlExtensions"]
}

model User {
  id        String   @id @default(uuid())  // Changed: UUID instead of Int
  email     String   @unique
  createdAt DateTime @default(now())
  posts     Post[]

  @@index([email])  // Added: Performance optimization
}

model Post {
  id        String   @id @default(uuid())
  title     String
  content   String   @db.Text  // Added: PostgreSQL-specific type
  userId    String
  user      User     @relation(fields: [userId], references: [id])

  @@index([userId])  // Added: Foreign key index
}
```

```typescript
// Server with connection pooling
import { PrismaClient } from '@prisma/client'
import { Pool } from '@neondatabase/serverless'

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: process.env.DATABASE_URL,
    },
  },
}).$extends({
  query: {
    $allOperations({ operation, model, args, query }) {
      // Connection pooling middleware
      return query(args)
    },
  },
})
```

### Known Gotchas & Implementation Notes

```markdown
# CRITICAL: ID Column Type Change
- SQLite uses INTEGER auto-increment
- PostgreSQL best practice: Use UUID
- Must migrate all foreign keys to UUID

# Migration Strategy: Blue-Green Deployment
1. Provision new PostgreSQL database (green)
2. Migrate schema and data
3. Run application in read-only mode during migration
4. Switch DNS/connection string to PostgreSQL
5. Monitor for 24 hours
6. Keep SQLite as backup for 7 days

# Data Migration Tools
- Use Prisma db push for schema (avoid migrate for this transformation)
- Custom Node.js script for data transfer (handles type conversions)
- pg_dump NOT suitable (coming from SQLite)

# Performance Considerations
- Add indexes AFTER data migration (faster than during)
- Use COPY for bulk inserts (faster than INSERT)
- Analyze tables after migration for query planner

# Connection Pooling
- SQLite: Single file, no pooling needed
- PostgreSQL: Connection limit (default 100)
- Use PgBouncer or built-in Prisma pooling
- Configure: max connections = 10 per instance

# Testing Strategy
- Unit tests: Use in-memory PostgreSQL (testcontainers)
- Integration tests: Staging PostgreSQL instance
- Load tests: Verify performance SLA
- Rollback test: Switch back to SQLite

# Rollback Plan
1. Keep SQLite .db file as backup
2. Keep Prisma schema for SQLite in git history
3. If rollback needed: Update DATABASE_URL, restart app
4. No data loss: SQLite frozen at migration time
```

## Implementation Blueprint

### Phase 1: Provision PostgreSQL (30 min)

```bash
# Option A: Railway
railway login
railway init
railway add postgresql
railway link [project-id]

# Option B: Supabase
# Create project at supabase.com
# Get connection string: postgres://[user]:[password]@[host]:5432/[db]

# Option C: Local Docker (for testing)
docker run --name postgres-migration \
  -e POSTGRES_PASSWORD=dev \
  -e POSTGRES_DB=appdb \
  -p 5432:5432 \
  -d postgres:15
```

**Validation:**
- Connect with psql: `psql $DATABASE_URL`
- Verify version: `SELECT version();`
- Test write: `CREATE TABLE test (id SERIAL); DROP TABLE test;`

---

### Phase 2: Update Prisma Schema (45 min)

```prisma
// prisma/schema.prisma

// Save current schema first!
// cp prisma/schema.prisma prisma/schema.sqlite.prisma

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// Update all models:
// 1. Change @id fields from Int to String @default(uuid())
// 2. Add indexes for foreign keys
// 3. Add PostgreSQL-specific types where beneficial

model User {
  id        String   @id @default(uuid())
  email     String   @unique
  createdAt DateTime @default(now())
  posts     Post[]

  @@index([email])
}

// Repeat for all 12 models...
```

**Validation:**
- Dry run: `npx prisma migrate diff --from-schema-datamodel prisma/schema.sqlite.prisma --to-schema-datamodel prisma/schema.prisma`
- Generate client: `npx prisma generate`
- Check for type errors in codebase

---

### Phase 3: Create Migration Script (60 min)

```typescript
// scripts/migrate-to-postgres.ts

import { PrismaClient as SQLiteClient } from '@prisma/client-sqlite'
import { PrismaClient as PostgresClient } from '@prisma/client'
import crypto from 'crypto'

const sqlite = new SQLiteClient({
  datasources: { db: { url: 'file:./app.db' } },
})

const postgres = new PostgresClient({
  datasources: { db: { url: process.env.DATABASE_URL } },
})

async function migrateTable(tableName: string) {
  console.log(`Migrating ${tableName}...`)

  // 1. Get all rows from SQLite
  const rows = await sqlite[tableName].findMany()

  console.log(`  Found ${rows.length} rows`)

  // 2. Transform ID fields (Int → UUID)
  const transformed = rows.map(row => ({
    ...row,
    id: generateUUIDFromInt(row.id),  // Deterministic UUID
    // Transform foreign keys too
    userId: row.userId ? generateUUIDFromInt(row.userId) : null,
  }))

  // 3. Batch insert to PostgreSQL (1000 at a time)
  for (let i = 0; i < transformed.length; i += 1000) {
    const batch = transformed.slice(i, i + 1000)
    await postgres[tableName].createMany({
      data: batch,
      skipDuplicates: true,
    })
    console.log(`  Migrated ${i + batch.length}/${transformed.length}`)
  }

  // 4. Verify row count
  const pgCount = await postgres[tableName].count()
  if (pgCount !== rows.length) {
    throw new Error(`Row count mismatch: SQLite ${rows.length}, PG ${pgCount}`)
  }

  console.log(`  ✅ ${tableName} migration complete`)
}

function generateUUIDFromInt(id: number): string {
  // Deterministic UUID from integer
  const hash = crypto.createHash('sha256').update(id.toString()).digest('hex')
  return `${hash.substr(0, 8)}-${hash.substr(8, 4)}-${hash.substr(12, 4)}-${hash.substr(16, 4)}-${hash.substr(20, 12)}`
}

async function main() {
  console.log('Starting migration...')

  // Migrate in order (respect foreign keys)
  await migrateTable('user')
  await migrateTable('post')
  // ... all 12 tables in dependency order

  console.log('✅ All tables migrated')

  // Verify data integrity
  const sqliteUserCount = await sqlite.user.count()
  const pgUserCount = await postgres.user.count()

  if (sqliteUserCount !== pgUserCount) {
    throw new Error('Data integrity check failed!')
  }

  console.log('✅ Data integrity verified')
}

main()
  .catch(console.error)
  .finally(async () => {
    await sqlite.$disconnect()
    await postgres.$disconnect()
  })
```

**Validation:**
- Test on local PostgreSQL first
- Verify row counts: `SELECT COUNT(*) FROM users;`
- Spot-check random rows for data accuracy
- Test foreign key constraints work

---

### Phase 4: Application Updates (30 min)

```typescript
// Update environment variables
// .env.production
DATABASE_URL="postgresql://user:pass@host:5432/db"

// src/server.ts
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient({
  datasources: {
    db: { url: process.env.DATABASE_URL },
  },
  log: ['query', 'error', 'warn'],  // Monitor performance
})

// Update any SQLite-specific code
// - Remove PRAGMA statements
// - Update date handling if needed
// - Replace AUTOINCREMENT with UUID
```

**Validation:**
- Run application locally with PostgreSQL
- Test all critical user flows
- Check GraphQL resolvers work
- Monitor query performance

---

### Phase 5: Deployment (Blue-Green) (60 min)

```bash
# 1. Enable maintenance mode
echo "Under maintenance - back in 10 minutes" > public/maintenance.html

# 2. Take final SQLite snapshot
cp app.db app.db.backup-$(date +%Y%m%d)

# 3. Run migration script
ts-node scripts/migrate-to-postgres.ts

# 4. Run database analysis
psql $DATABASE_URL -c "ANALYZE;"

# 5. Create indexes (now that data is loaded)
psql $DATABASE_URL -f scripts/create-indexes.sql

# 6. Update production DATABASE_URL
railway variables set DATABASE_URL="postgresql://..."

# 7. Deploy application
git push production main

# 8. Monitor for 5 minutes
railway logs --tail

# 9. Disable maintenance mode
rm public/maintenance.html

# 10. Monitor metrics for 24 hours
# - Query latency
# - Error rate
# - Connection pool saturation
```

**Validation:**
- Smoke test all critical endpoints
- Run automated test suite
- Check error logs for database issues
- Verify data in production PostgreSQL

---

## Validation Loop

### Level 1: Pre-Migration Validation

```bash
# Verify schema compatibility
npx prisma migrate diff \
  --from-schema-datamodel prisma/schema.sqlite.prisma \
  --to-schema-datamodel prisma/schema.prisma

# Expected: Only datasource and ID type changes

# Verify Prisma client generates correctly
npx prisma generate

# Expected: No TypeScript errors
npm run type-check
```

### Level 2: Migration Script Validation

```bash
# Test on local PostgreSQL
export DATABASE_URL="postgresql://localhost:5432/test"
npx prisma db push

ts-node scripts/migrate-to-postgres.ts

# Verify row counts match
psql $DATABASE_URL -c "SELECT 'users', COUNT(*) FROM users UNION ALL SELECT 'posts', COUNT(*) FROM posts;"

# Compare to SQLite
sqlite3 app.db "SELECT 'users', COUNT(*) FROM users UNION ALL SELECT 'posts', COUNT(*) FROM posts;"

# Expected: Counts match exactly
```

### Level 3: Application Integration Validation

```bash
# Run test suite against PostgreSQL
export DATABASE_URL="postgresql://localhost:5432/test"
npm test

# Expected: All tests pass

# Run integration tests
npm run test:integration

# Load test (compare to SQLite baseline)
artillery run load-test.yml

# Expected: <100ms p95 latency
```

### Level 4: Production Validation

```bash
# After deployment, verify critical paths
curl https://api.example.com/health
# Expected: {"status":"ok","database":"connected"}

# Check query performance
psql $DATABASE_URL -c "SELECT query, mean_exec_time FROM pg_stat_statements ORDER BY mean_exec_time DESC LIMIT 10;"

# Monitor error rate (should be <0.1%)
railway logs --filter "error"

# If issues: Rollback plan
# 1. Update DATABASE_URL back to SQLite
# 2. Deploy previous version
# 3. Investigate issues before retry
```

---

**Generated**: [DATE]
**Status**: Ready for execution
**Estimated time**: 4-6 hours (including monitoring)
**Risk level**: Medium (mitigated with blue-green deployment)
