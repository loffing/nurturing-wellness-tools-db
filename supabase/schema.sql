-- Nurturing Wellness Clinical Companion - Complete Supabase Database Schema
-- Combined Base Schema + Clinical Metadata Extensions + User Profile Trigger

-- 1. Practice Curated Library Table
CREATE TABLE IF NOT EXISTS public.practice_books (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  isbn TEXT,
  google_books_id TEXT,
  info_link TEXT,
  title TEXT NOT NULL,
  authors TEXT[] DEFAULT '{}',
  cover_image TEXT,
  reading_level TEXT,
  maturity_age_min INT DEFAULT 4,
  maturity_age_max INT DEFAULT 18,
  clinical_topics TEXT[] DEFAULT '{}',
  sensitivity_flags TEXT[] DEFAULT '{}',
  gifted_kid_suitability TEXT,
  therapist_notes TEXT,
  parent_blurb TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Patient Records Table
CREATE TABLE IF NOT EXISTS public.patients (
  id TEXT PRIMARY KEY,
  display_name TEXT NOT NULL,
  age INT,
  primary_therapist_id UUID REFERENCES auth.users(id),
  status TEXT DEFAULT 'Active',
  demographics TEXT,
  primary_focus TEXT,
  secondary_focus TEXT,
  referral_source TEXT,
  modalities TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Patient Recommended Reading Lists Table
CREATE TABLE IF NOT EXISTS public.reading_lists (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id TEXT REFERENCES public.patients(id) ON DELETE CASCADE,
  therapist_id UUID REFERENCES auth.users(id),
  book_ids TEXT[] DEFAULT '{}',
  custom_note TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Clinical Timeline Events Table
CREATE TABLE IF NOT EXISTS public.timeline_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id TEXT REFERENCES public.patients(id) ON DELETE CASCADE,
  category TEXT NOT NULL,
  title TEXT NOT NULL,
  event_date DATE NOT NULL,
  relative_age TEXT,
  impact_score INT DEFAULT 1,
  description TEXT,
  status TEXT DEFAULT 'Completed',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. User Profiles Table for Practice Staff
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  display_name TEXT NOT NULL,
  role TEXT DEFAULT 'therapist',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.practice_books ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reading_lists ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.timeline_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Drop policies if re-running script to avoid duplicate policy errors
DROP POLICY IF EXISTS "Therapist Access Policy" ON public.practice_books;
DROP POLICY IF EXISTS "Therapist Patients Policy" ON public.patients;
DROP POLICY IF EXISTS "Therapist Reading Lists Policy" ON public.reading_lists;
DROP POLICY IF EXISTS "Therapist Timeline Policy" ON public.timeline_events;
DROP POLICY IF EXISTS "Therapist Profiles Policy" ON public.profiles;

-- Allow authenticated practice therapists full access
CREATE POLICY "Therapist Access Policy" ON public.practice_books FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Therapist Patients Policy" ON public.patients FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Therapist Reading Lists Policy" ON public.reading_lists FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Therapist Timeline Policy" ON public.timeline_events FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "Therapist Profiles Policy" ON public.profiles FOR ALL USING (auth.role() = 'authenticated');

-- Automatic Profile Creation Trigger on Auth Signup/Invite
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, display_name, role)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'displayName', SPLIT_PART(NEW.email, '@', 1)),
    COALESCE(NEW.raw_user_meta_data->>'role', 'therapist')
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    display_name = EXCLUDED.display_name;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
