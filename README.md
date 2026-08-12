# Nurturing Wellness Clinical Companion — Database Schema

This repository contains the PostgreSQL database schema definitions, Row Level Security (RLS) policies, and Supabase migrations for the **Nurturing Wellness Clinical Companion** application across both Development and Production environments.

## Directory Structure

```
nurturing-wellness-tools-db/
├── dev/
│   └── supabase/
│       ├── config.toml
│       └── migrations/     # Migration SQL scripts for Development project
└── prod/
    └── supabase/
        ├── config.toml
        └── migrations/     # Migration SQL scripts for Production project
```

## Workflow & Managing Database Changes

This repository manages two distinct Supabase projects (`nurturing-wellness-dev` and `nurturing-wellness-prod`).

### 1. Development Workflow (`dev/`)

You can modify the development database in one of two ways:

#### Option A: Dashboard-first (Pull remote changes)
1. Make schema or policy changes in the **Development Supabase Dashboard**.
2. Pull the changes into a new migration file:
   ```bash
   cd dev
   npx supabase db pull --db-url postgresql://postgres:<DB_PASSWORD>@db.<DEV_PROJECT_REF>.supabase.co:5432/postgres
   ```
3. Commit the generated SQL migration file under `dev/supabase/migrations/`.

#### Option B: Code-first (Local migration creation)
1. Create a new migration file:
   ```bash
   cd dev
   npx supabase migration new <migration_name>
   ```
2. Add your DDL SQL commands to the generated file in `dev/supabase/migrations/`.
3. Apply migrations to the development database:
   ```bash
   cd dev
   npx supabase db push --db-url postgresql://postgres:<DB_PASSWORD>@db.<DEV_PROJECT_REF>.supabase.co:5432/postgres
   ```

---

### 2. Promoting Changes to Production (`prod/`)

Once database changes are tested and verified in Development:

1. Copy the verified migration file(s) from `dev/supabase/migrations/` into `prod/supabase/migrations/`.
2. Apply the pending migrations to Production:
   ```bash
   cd prod
   npx supabase db push --db-url postgresql://postgres:<DB_PASSWORD>@db.<PROD_PROJECT_REF>.supabase.co:5432/postgres
   ```
3. Commit and push the changes to GitHub.

