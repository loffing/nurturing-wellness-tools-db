-- Migration: Add DEFAULT '' to email column on public.profiles to prevent NOT NULL upsert failures
ALTER TABLE public.profiles ALTER COLUMN email SET DEFAULT '';
