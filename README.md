# Nurturing Wellness Clinical Companion — Database Schema

This repository contains the PostgreSQL database schema definitions and Row Level Security (RLS) policies for the **Nurturing Wellness Clinical Companion** application built on **Supabase**.

## Directory Structure

```
nurturing-wellness-tools-db/
└── supabase/
    └── schema.sql    # Combined database tables, RLS policies, and profile trigger
```

## How to Apply Schema

1. Log into your project dashboard at [Supabase.com](https://supabase.com/).
2. Navigate to **SQL Editor** > **New query**.
3. Copy and paste the contents of `supabase/schema.sql`.
4. Click **Run**.

Repeat these steps for both your **Development** (`nurturing-wellness-dev`) and **Production** (`nurturing-wellness-prod`) Supabase projects.
