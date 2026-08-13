-- Migration: Add title, description, and created_at columns to public.reading_lists for playlist-style reading lists
ALTER TABLE public.reading_lists ADD COLUMN IF NOT EXISTS title TEXT NOT NULL DEFAULT 'Curated Reading List';
ALTER TABLE public.reading_lists ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE public.reading_lists ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW();

-- Reload PostgREST schema cache
NOTIFY pgrst, 'reload schema';
