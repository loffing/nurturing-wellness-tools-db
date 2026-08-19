-- Migration: Add suds_score column to timeline_events
ALTER TABLE public.timeline_events ADD COLUMN IF NOT EXISTS suds_score INT CHECK (suds_score >= 1 AND suds_score <= 10);
