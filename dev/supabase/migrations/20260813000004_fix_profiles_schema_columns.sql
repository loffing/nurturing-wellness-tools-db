-- Migration: Add missing columns to public.profiles and reload PostgREST schema cache
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS full_name TEXT NOT NULL DEFAULT 'Clinical Practitioner';
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS credentials TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS clinical_title TEXT DEFAULT 'Licensed Child & Adolescent Therapist';
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS avatar_url TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- Reload PostgREST schema cache so Supabase API immediately recognizes new columns
NOTIFY pgrst, 'reload schema';
