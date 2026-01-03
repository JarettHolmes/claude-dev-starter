name: "User Authentication System with JWT"
description: |
  Implement complete authentication system with JWT tokens, including login/logout,
  token refresh, protected routes, and session management.

---

## Goal

Build a secure, production-ready authentication system that allows users to register, log in, and access protected resources using JWT tokens with automatic refresh.

## Why

**For users**: Secure access to their accounts with persistent sessions
**For developers**: Clear authentication patterns that prevent common security mistakes
**For the application**: Foundation for role-based access control and user-specific features

## What

### User-Visible Behavior

1. **Registration**: Users can create accounts with email/password
   - Email validation and uniqueness check
   - Password strength requirements enforced
   - Confirmation email sent (stub for now)

2. **Login**: Users can authenticate with credentials
   - Returns access token (short-lived, 15 min)
   - Returns refresh token (long-lived, 7 days)
   - Tokens stored securely

3. **Protected Routes**: Authenticated users can access protected resources
   - Automatic token refresh when access token expires
   - Redirect to login if refresh token expires
   - Persistent sessions across browser refreshes

4. **Logout**: Users can end their session
   - Clears tokens from storage
   - Invalidates refresh token on server
   - Redirects to login page

### Success Criteria

- [ ] User can register with email/password
- [ ] User can log in and receive tokens
- [ ] Access tokens expire after 15 minutes
- [ ] Refresh tokens automatically renew access tokens
- [ ] Protected routes require valid authentication
- [ ] Logout clears all session data
- [ ] Sessions persist across page refreshes
- [ ] All tokens stored in httpOnly cookies (not localStorage)

## All Needed Context

### Documentation & References

```yaml
# Project Patterns (from AI_DOMAIN_TRANSLATION_GUIDE.md)
- Database: Prisma ORM with TypeScript types
  Pattern: Always use `include` for relations
  Example: prisma.user.findUnique({ where: { id }, include: { profile: true } })

- API Layer: tRPC procedures with end-to-end type safety
  Pattern: Define input schemas with Zod, use .query() or .mutation()
  Gotcha: Never use fetch() for internal APIs

- State Management: Zustand stores
  Pattern: Create store in src/stores/, use hooks in components
  Location: src/stores/auth.ts

- Forms: React Hook Form with Zod validation
  Pattern: Define schema first, use resolver: zodResolver(schema)
  Location: src/schemas/

- Styling: Tailwind CSS utility classes
  Pattern: Use design tokens from tailwind.config.js
  No custom CSS modules
```

### Current Codebase State

```typescript
// Database Schema (Prisma)
model User {
  id            String   @id @default(cuid())
  email         String   @unique
  passwordHash  String
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  // Add: refreshToken, refreshTokenExpiry fields
}

// Existing Auth Store (src/stores/auth.ts)
// Currently: Simple useState, needs Zustand migration

// API Routes
// Existing: src/server/api/routers/ (needs auth router)

// Protected Routes
// Pattern: Use middleware in tRPC procedures
```

### Desired Codebase State

```
src/
├── server/
│   ├── api/
│   │   ├── routers/
│   │   │   └── auth.ts          # New: Auth procedures
│   │   └── middleware/
│   │       └── auth.ts          # New: JWT verification middleware
│   └── lib/
│       └── jwt.ts               # New: Token generation/validation
├── stores/
│   └── auth.ts                  # Modified: Add Zustand store
├── schemas/
│   └── auth.ts                  # New: Zod schemas for login/register
├── components/
│   ├── LoginForm.tsx            # New: Login component
│   └── ProtectedRoute.tsx       # New: Route guard component
└── pages/
    ├── login.tsx                # New: Login page
    └── register.tsx             # New: Registration page

prisma/schema.prisma             # Modified: Add refresh token fields
```

### Known Gotchas & Implementation Notes

```markdown
# CRITICAL: Password Security
- NEVER store plain-text passwords
- Use bcrypt with at least 10 rounds
- Hash passwords before storing in database

# Token Storage
- Store tokens in httpOnly cookies, NOT localStorage
- localStorage vulnerable to XSS attacks
- Cookies: { httpOnly: true, secure: true, sameSite: 'strict' }

# JWT Secrets
- Use strong secret (32+ characters)
- Store in environment variable
- Different secrets for access/refresh tokens

# Token Expiry
- Access token: Short-lived (15 min)
- Refresh token: Long-lived (7 days)
- Implement sliding sessions (refresh extends expiry)

# Prisma Patterns
- Use `select` instead of `include` for sensitive fields
- Never return passwordHash in queries
- Example: prisma.user.findUnique({ select: { id: true, email: true } })

# tRPC Authentication
- Use middleware to verify JWT before protected procedures
- Throw UNAUTHORIZED error if invalid
- Attach user to ctx for downstream use
```

## Implementation Blueprint

### Phase 1: Database Schema (15 min)

```prisma
// prisma/schema.prisma

model User {
  id                  String    @id @default(cuid())
  email               String    @unique
  passwordHash        String
  refreshToken        String?
  refreshTokenExpiry  DateTime?
  createdAt           DateTime  @default(now())
  updatedAt           DateTime  @updatedAt

  @@index([email])
}
```

**Validation:**
- Run `npx prisma migrate dev --name add-auth-fields`
- Verify migration creates refresh token fields
- Test with `npx prisma studio` to confirm schema

---

### Phase 2: JWT Library (20 min)

```typescript
// src/server/lib/jwt.ts

import jwt from 'jsonwebtoken';

const ACCESS_SECRET = process.env.JWT_ACCESS_SECRET!;
const REFRESH_SECRET = process.env.JWT_REFRESH_SECRET!;

export function generateAccessToken(userId: string): string {
  return jwt.sign({ userId }, ACCESS_SECRET, { expiresIn: '15m' });
}

export function generateRefreshToken(userId: string): string {
  return jwt.sign({ userId }, REFRESH_SECRET, { expiresIn: '7d' });
}

export function verifyAccessToken(token: string): { userId: string } {
  return jwt.verify(token, ACCESS_SECRET) as { userId: string };
}

export function verifyRefreshToken(token: string): { userId: string } {
  return jwt.verify(token, REFRESH_SECRET) as { userId: string };
}
```

**Validation:**
- Add JWT_ACCESS_SECRET and JWT_REFRESH_SECRET to .env
- Test token generation: `generateAccessToken('test-id')`
- Test verification: `verifyAccessToken(token)`
- Confirm expiry after 15 min (access) and 7 days (refresh)

---

### Phase 3: Authentication Router (30 min)

```typescript
// src/server/api/routers/auth.ts

import { z } from 'zod';
import bcrypt from 'bcrypt';
import { router, publicProcedure } from '../trpc';
import { generateAccessToken, generateRefreshToken } from '../../lib/jwt';

export const authRouter = router({
  register: publicProcedure
    .input(z.object({
      email: z.string().email(),
      password: z.string().min(8),
    }))
    .mutation(async ({ input, ctx }) => {
      const { email, password } = input;

      // Check if user exists
      const existing = await ctx.prisma.user.findUnique({ where: { email } });
      if (existing) throw new Error('Email already registered');

      // Hash password
      const passwordHash = await bcrypt.hash(password, 10);

      // Create user
      const user = await ctx.prisma.user.create({
        data: { email, passwordHash },
        select: { id: true, email: true },
      });

      return { user };
    }),

  login: publicProcedure
    .input(z.object({
      email: z.string().email(),
      password: z.string(),
    }))
    .mutation(async ({ input, ctx }) => {
      const { email, password } = input;

      // Find user
      const user = await ctx.prisma.user.findUnique({
        where: { email },
      });
      if (!user) throw new Error('Invalid credentials');

      // Verify password
      const valid = await bcrypt.compare(password, user.passwordHash);
      if (!valid) throw new Error('Invalid credentials');

      // Generate tokens
      const accessToken = generateAccessToken(user.id);
      const refreshToken = generateRefreshToken(user.id);

      // Store refresh token
      await ctx.prisma.user.update({
        where: { id: user.id },
        data: {
          refreshToken,
          refreshTokenExpiry: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
        },
      });

      return {
        accessToken,
        refreshToken,
        user: { id: user.id, email: user.email },
      };
    }),

  refreshToken: publicProcedure
    .input(z.object({ refreshToken: z.string() }))
    .mutation(async ({ input, ctx }) => {
      const { userId } = verifyRefreshToken(input.refreshToken);

      // Verify refresh token in database
      const user = await ctx.prisma.user.findFirst({
        where: {
          id: userId,
          refreshToken: input.refreshToken,
          refreshTokenExpiry: { gte: new Date() },
        },
      });

      if (!user) throw new Error('Invalid refresh token');

      // Generate new access token
      const accessToken = generateAccessToken(user.id);

      return { accessToken };
    }),

  logout: publicProcedure
    .input(z.object({ userId: z.string() }))
    .mutation(async ({ input, ctx }) => {
      await ctx.prisma.user.update({
        where: { id: input.userId },
        data: { refreshToken: null, refreshTokenExpiry: null },
      });

      return { success: true };
    }),
});
```

**Validation:**
- Test register with valid email/password
- Confirm passwordHash in database (not plain text)
- Test login returns accessToken and refreshToken
- Test refreshToken endpoint generates new access token
- Test logout clears refresh token in database

---

### Phase 4: Auth Middleware (15 min)

```typescript
// src/server/api/middleware/auth.ts

import { TRPCError } from '@trpc/server';
import { verifyAccessToken } from '../../lib/jwt';
import { middleware } from '../trpc';

export const isAuthenticated = middleware(async ({ ctx, next }) => {
  const token = ctx.req.cookies.accessToken;

  if (!token) {
    throw new TRPCError({ code: 'UNAUTHORIZED' });
  }

  try {
    const { userId } = verifyAccessToken(token);
    const user = await ctx.prisma.user.findUnique({
      where: { id: userId },
      select: { id: true, email: true },
    });

    if (!user) throw new TRPCError({ code: 'UNAUTHORIZED' });

    return next({ ctx: { ...ctx, user } });
  } catch (error) {
    throw new TRPCError({ code: 'UNAUTHORIZED' });
  }
});

// Usage in protected procedures
export const protectedProcedure = publicProcedure.use(isAuthenticated);
```

**Validation:**
- Test protected procedure without token (should throw UNAUTHORIZED)
- Test with valid token (should attach user to ctx)
- Test with expired token (should throw UNAUTHORIZED)

---

### Phase 5: Frontend Auth Store (20 min)

```typescript
// src/stores/auth.ts

import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface User {
  id: string;
  email: string;
}

interface AuthState {
  user: User | null;
  accessToken: string | null;
  refreshToken: string | null;
  setAuth: (user: User, accessToken: string, refreshToken: string) => void;
  clearAuth: () => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      accessToken: null,
      refreshToken: null,
      setAuth: (user, accessToken, refreshToken) =>
        set({ user, accessToken, refreshToken }),
      clearAuth: () =>
        set({ user: null, accessToken: null, refreshToken: null }),
    }),
    { name: 'auth-storage' }
  )
);
```

**Validation:**
- Test setAuth updates store
- Test clearAuth resets store
- Test persistence across page refresh

---

### Phase 6: Login Component (25 min)

```typescript
// src/components/LoginForm.tsx

import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { trpc } from '../utils/trpc';
import { useAuthStore } from '../stores/auth';

const loginSchema = z.object({
  email: z.string().email('Invalid email'),
  password: z.string().min(8, 'Password must be at least 8 characters'),
});

type LoginInput = z.infer<typeof loginSchema>;

export function LoginForm() {
  const setAuth = useAuthStore((state) => state.setAuth);
  const { register, handleSubmit, formState: { errors } } = useForm<LoginInput>({
    resolver: zodResolver(loginSchema),
  });

  const loginMutation = trpc.auth.login.useMutation({
    onSuccess: (data) => {
      setAuth(data.user, data.accessToken, data.refreshToken);
      // Redirect to dashboard
    },
  });

  const onSubmit = (data: LoginInput) => {
    loginMutation.mutate(data);
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
      <div>
        <label className="block text-sm font-medium">Email</label>
        <input
          {...register('email')}
          type="email"
          className="mt-1 block w-full rounded-md border-gray-300"
        />
        {errors.email && (
          <p className="text-red-500 text-sm">{errors.email.message}</p>
        )}
      </div>

      <div>
        <label className="block text-sm font-medium">Password</label>
        <input
          {...register('password')}
          type="password"
          className="mt-1 block w-full rounded-md border-gray-300"
        />
        {errors.password && (
          <p className="text-red-500 text-sm">{errors.password.message}</p>
        )}
      </div>

      <button
        type="submit"
        disabled={loginMutation.isLoading}
        className="w-full bg-blue-600 text-white py-2 rounded-md"
      >
        {loginMutation.isLoading ? 'Logging in...' : 'Login'}
      </button>

      {loginMutation.error && (
        <p className="text-red-500 text-sm">{loginMutation.error.message}</p>
      )}
    </form>
  );
}
```

**Validation:**
- Test form validation (email format, password length)
- Test successful login updates auth store
- Test error handling for invalid credentials

---

## Validation Loop

### Level 1: Unit Tests

```typescript
// Test JWT generation/verification
describe('JWT', () => {
  it('generates valid access token', () => {
    const token = generateAccessToken('user-123');
    const decoded = verifyAccessToken(token);
    expect(decoded.userId).toBe('user-123');
  });
});

// Test auth router
describe('Auth Router', () => {
  it('registers new user', async () => {
    const result = await caller.auth.register({
      email: 'test@example.com',
      password: 'password123',
    });
    expect(result.user.email).toBe('test@example.com');
  });
});
```

### Level 2: Integration Tests

```typescript
// Test login flow end-to-end
it('complete login flow', async () => {
  // Register
  await caller.auth.register({ email: 'test@example.com', password: 'pass123' });

  // Login
  const { accessToken, refreshToken } = await caller.auth.login({
    email: 'test@example.com',
    password: 'pass123',
  });

  expect(accessToken).toBeDefined();
  expect(refreshToken).toBeDefined();

  // Verify token works
  const decoded = verifyAccessToken(accessToken);
  expect(decoded.userId).toBeDefined();
});
```

### Level 3: Manual Testing

```bash
# 1. Register user
curl -X POST http://localhost:3000/api/trpc/auth.register \
  -d '{"email":"test@example.com","password":"password123"}'

# 2. Login
curl -X POST http://localhost:3000/api/trpc/auth.login \
  -d '{"email":"test@example.com","password":"password123"}'

# 3. Access protected route
curl http://localhost:3000/api/trpc/protected.getData \
  -H "Cookie: accessToken=..."

# 4. Refresh token
curl -X POST http://localhost:3000/api/trpc/auth.refreshToken \
  -d '{"refreshToken":"..."}'

# 5. Logout
curl -X POST http://localhost:3000/api/trpc/auth.logout \
  -d '{"userId":"..."}'
```

---

**Generated**: [DATE]
**Status**: Ready for implementation
**Estimated time**: 2-3 hours
