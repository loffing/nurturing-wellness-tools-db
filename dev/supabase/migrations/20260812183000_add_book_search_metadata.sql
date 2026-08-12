-- Migration: Add discovery search query & keyword metadata to practice_books
ALTER TABLE public.practice_books ADD COLUMN IF NOT EXISTS source_query TEXT;
ALTER TABLE public.practice_books ADD COLUMN IF NOT EXISTS search_keywords TEXT[] DEFAULT '{}';
