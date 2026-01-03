# Web App - Capability Limits Snippets

## Documented Limits

### Build Tool (Vite)

- **Issue**: Vite error messages can be truncated in terminal output, hiding root cause
- **Threshold**: N/A (happens intermittently)
- **Workaround**: Always check `vite.config.ts` when build fails; look for plugin errors
- **Tested**: 2024-12, 15 builds, 60% of failures had truncated messages
- **Workaround Reference**: Check full error in browser console or `vite.log`

### TypeScript Inference

- **Issue**: Complex generic types (3+ levels of nesting) may need explicit annotations
- **Threshold**: 3+ nested generics = explicit type required
- **Workaround**: Add explicit return types to functions with complex generics
- **Tested**: 2024-11, 8 instances, 100% reproducible
- **Workaround Reference**:
```typescript
// Inference fails - error unclear
function complexMap(items) {
  return items.map(item => transform(item))
}

// Explicit type - clear errors
function complexMap<T, R>(items: T[]): R[] {
  return items.map(item => transform(item))
}
```

### React Query Cache

- **Issue**: Default stale time is 0, causing excessive refetches
- **Threshold**: Every component mount triggers refetch
- **Workaround**: Set global `staleTime` in QueryClient config
- **Tested**: 2024-10, monitoring showed 100+ unnecessary requests/min
- **Workaround Reference**:
```typescript
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 1000 * 60 * 5  // 5 minutes
    }
  }
})
```

## Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| Bundle size | Vite may have threshold for production builds (too large = slow) | Test with varying component counts, measure build time and size | MEDIUM |
| Hot reload | HMR may fail with circular dependencies | Create intentional circular refs, test HMR behavior | LOW |
| Prisma connection pool | May exhaust at >100 concurrent connections | Load test with varying concurrency, monitor connection errors | HIGH |
| Image optimization | May have size limit for automatic optimization | Upload images of varying sizes, check optimization behavior | MEDIUM |
| LocalStorage quota | Browser limit ~5-10MB, varies by browser | Fill localStorage incrementally, catch QuotaExceededError | LOW |

## Documented Workarounds

### Circular Dependency Detection
```bash
# Use madge to detect circular dependencies
npx madge --circular src/

# Output shows circular import chains
# Fix by refactoring or using lazy loading
```

### Prisma Connection Pool Monitoring
```typescript
// Add to server startup
prisma.$on('query', (e) => {
  console.log('Query: ' + e.query)
  console.log('Duration: ' + e.duration + 'ms')
})

// Monitor active connections
const connections = await prisma.$metrics.json()
console.log('Active connections:', connections)
```

### Vite Build Debug Mode
```bash
# Run build with debug output
DEBUG=vite:* npm run build

# Or check specific plugin
DEBUG=vite:plugin-react npm run build
```
