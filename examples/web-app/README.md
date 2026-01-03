# Web App Example

This example shows how to customize the AI guides for a **React/TypeScript web application**.

## Technology Stack

- **Frontend**: React 18 + TypeScript
- **Build Tool**: Vite
- **Styling**: Tailwind CSS
- **State Management**: Zustand
- **API Layer**: tRPC (end-to-end type safety)
- **Database**: Prisma + PostgreSQL
- **Auth**: NextAuth.js
- **Form Handling**: React Hook Form + Zod
- **Data Fetching**: React Query (via tRPC)

## What's Included

### AI_DOMAIN_TRANSLATION.snippet.md

**10 concept mappings**:
1. Database query → Prisma ORM
2. State management → Zustand stores
3. API call → tRPC procedures
4. Component → React .tsx files
5. Styling → Tailwind utility classes
6. Routing → React Router v6
7. Form validation → Zod schemas
8. Authentication → NextAuth.js
9. Environment vars → import.meta.env
10. Build output → dist/

**5 anti-patterns**:
1. ❌ Using fetch() for internal APIs
2. ❌ Inline Tailwind without design tokens
3. ❌ Component state for global data
4. ❌ Fetching data in useEffect
5. ❌ N+1 queries with Prisma

**4 quick reference patterns**:
- Database query with relations (Prisma)
- API call (tRPC)
- Global state (Zustand)
- Form with validation (React Hook Form + Zod)

### AI_CAPABILITIES_LIMITS.snippet.md

**3 documented limits**:
1. Vite error message truncation
2. TypeScript inference with complex generics
3. React Query default stale time

**5 future tests**:
- Bundle size thresholds
- Hot reload with circular dependencies
- Prisma connection pool limits
- Image optimization limits
- LocalStorage quota

## How to Use

### Step 1: Copy Snippets to Your Guides

```bash
# From starter kit root
cd /path/to/your/project

# Copy concept mappings
cat examples/web-app/AI_DOMAIN_TRANSLATION.snippet.md

# Manually copy relevant sections to your:
# docs/AI_DOMAIN_TRANSLATION_GUIDE.md
```

**Where to paste**:
- Concept mappings → "When You Think..." table
- Tool selection → "Tool Selection Matrix"
- Quick reference → "Quick Reference Patterns" section
- Anti-patterns → "Common Anti-Patterns" section

### Step 2: Customize for Your Stack

**Replace tools** if different:

**Example - Using Redux instead of Zustand**:
```markdown
| "State management" | Redux store with RTK slices in src/store/ | Use createSlice(), never hand-write reducers |
```

**Example - Using REST instead of tRPC**:
```markdown
| "API call" | Axios with React Query in src/api/ | Use query keys for caching, interceptors for auth |
```

**Keep the structure**, just swap tools:
- Format: `| "Concept" | "Your Tool" | "Key Detail" |`
- Anti-pattern format: `❌ Wrong → ✅ Right`
- Quick reference format: Code snippet + When + Why

### Step 3: Add Your Patterns

**Think about operations you do daily**:
- How do you add a new page?
- How do you fetch data?
- How do you handle errors?
- How do you test components?

**Add to concept mappings**:
```markdown
| "Error handling" | React Error Boundary + toast notifications | Use Sonner for toasts, ErrorBoundary for crashes |
| "Testing" | Vitest + React Testing Library | Test user behavior, not implementation |
```

### Step 4: Validate

```bash
bash tools/validate_ai_guides.sh /path/to/your/docs
```

**Expected**:
- ✅ 15+ mappings (you may have more with customizations)
- ✅ 5+ anti-patterns
- ✅ No broken links

## Expansion Ideas

Add mappings for:

### Deployment
```markdown
| "Deploy to production" | Vercel with automatic deploys from main branch | Set environment vars in Vercel dashboard |
```

### Testing
```markdown
| "Component test" | Vitest + React Testing Library in src/__tests__/ | Test user behavior, not implementation details |
| "E2E test" | Playwright tests in tests/e2e/ | Use data-testid for stable selectors |
```

### Monitoring
```markdown
| "Error tracking" | Sentry with React error boundary | Capture errors, don't just log to console |
| "Analytics" | Plausible Analytics (privacy-friendly) | Track page views and custom events |
```

### Performance
```markdown
| "Code splitting" | React.lazy() with Suspense | Split routes, not every component |
| "Image optimization" | next/image or @unpic/react | Automatic optimization, lazy loading |
```

## Real-World Usage

This pattern works for:
- **SaaS dashboards** (admin panels, analytics)
- **E-commerce** (product catalogs, checkout)
- **Social platforms** (feeds, profiles, messaging)
- **Internal tools** (CRUD apps, data management)

## Common Questions

**Q: What if I use Next.js instead of Vite?**
**A**: Adjust build tool references, but patterns mostly the same:
```markdown
| "Build output" | .next/ folder created by Next.js | Run `next build` before deployment |
| "Routing" | Next.js App Router with route.tsx files | Use Server Components by default |
```

**Q: What if I don't use tRPC?**
**A**: Replace with your API layer (REST, GraphQL):
```markdown
| "API call" | Axios + React Query in src/api/ | Use query/mutation hooks, not raw axios |
```

**Q: Should I include every tool we use?**
**A**: Focus on **common operations** (daily use). Add edge cases as you encounter them.

---

**Next**: After customizing, test with a validation scenario (see `examples/validation-scenarios-template.md`)
