-- Migration unit 1: schema_changes
-- Transaction mode: transactional
-- Boundary reason: default

CREATE TABLE public.patients (
  id                   text                     NOT NULL,
  display_name         text                     NOT NULL,
  age                  integer,
  primary_therapist_id uuid,
  status               text                     DEFAULT 'Active'::text,
  created_at           timestamp with time zone DEFAULT now(),
  demographics         text,
  primary_focus        text,
  secondary_focus      text,
  referral_source      text,
  modalities           text
);

ALTER TABLE public.patients
  ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.patients
  ADD CONSTRAINT patients_pkey PRIMARY KEY (id);

ALTER TABLE public.patients
  ADD CONSTRAINT patients_primary_therapist_id_fkey FOREIGN KEY (primary_therapist_id) REFERENCES auth.users(id);

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.patients TO anon;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.patients TO authenticated;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.patients TO service_role;

CREATE POLICY "Therapist Patients Policy" ON public.patients
  USING ((auth.role() = 'authenticated'::text));

CREATE TABLE public.practice_books (
  id                     uuid                     DEFAULT gen_random_uuid() NOT NULL,
  isbn                   text,
  google_books_id        text,
  info_link              text,
  title                  text                     NOT NULL,
  authors                text[]                   DEFAULT '{}'::text[],
  cover_image            text,
  reading_level          text,
  maturity_age_min       integer                  DEFAULT 4,
  maturity_age_max       integer                  DEFAULT 18,
  clinical_topics        text[]                   DEFAULT '{}'::text[],
  sensitivity_flags      text[]                   DEFAULT '{}'::text[],
  gifted_kid_suitability text,
  therapist_notes        text,
  parent_blurb           text,
  created_at             timestamp with time zone DEFAULT now()
);

ALTER TABLE public.practice_books
  ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.practice_books
  ADD CONSTRAINT practice_books_pkey PRIMARY KEY (id);

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.practice_books TO anon;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.practice_books TO authenticated;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.practice_books TO service_role;

CREATE POLICY "Therapist Access Policy" ON public.practice_books
  USING ((auth.role() = 'authenticated'::text));

CREATE TABLE public.profiles (
  id           uuid                     NOT NULL,
  email        text                     NOT NULL,
  display_name text                     NOT NULL,
  role         text                     DEFAULT 'therapist'::text,
  created_at   timestamp with time zone DEFAULT now()
);

ALTER TABLE public.profiles
  ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;

ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.profiles TO anon;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.profiles TO authenticated;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.profiles TO service_role;

CREATE POLICY "Therapist Profiles Policy" ON public.profiles
  USING ((auth.role() = 'authenticated'::text));

CREATE TABLE public.reading_lists (
  id           uuid                     DEFAULT gen_random_uuid() NOT NULL,
  patient_id   text,
  therapist_id uuid,
  book_ids     text[]                   DEFAULT '{}'::text[],
  custom_note  text,
  updated_at   timestamp with time zone DEFAULT now()
);

ALTER TABLE public.reading_lists
  ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.reading_lists
  ADD CONSTRAINT reading_lists_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(id) ON DELETE CASCADE;

ALTER TABLE public.reading_lists
  ADD CONSTRAINT reading_lists_pkey PRIMARY KEY (id);

ALTER TABLE public.reading_lists
  ADD CONSTRAINT reading_lists_therapist_id_fkey FOREIGN KEY (therapist_id) REFERENCES auth.users(id);

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.reading_lists TO anon;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.reading_lists TO authenticated;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.reading_lists TO service_role;

CREATE POLICY "Therapist Reading Lists Policy" ON public.reading_lists
  USING ((auth.role() = 'authenticated'::text));

CREATE TABLE public.timeline_events (
  id           uuid                     DEFAULT gen_random_uuid() NOT NULL,
  patient_id   text,
  category     text                     NOT NULL,
  title        text                     NOT NULL,
  event_date   date                     NOT NULL,
  description  text,
  status       text                     DEFAULT 'Completed'::text,
  created_at   timestamp with time zone DEFAULT now(),
  relative_age text,
  impact_score integer                  DEFAULT 1
);

ALTER TABLE public.timeline_events
  ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.timeline_events
  ADD CONSTRAINT timeline_events_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(id) ON DELETE CASCADE;

ALTER TABLE public.timeline_events
  ADD CONSTRAINT timeline_events_pkey PRIMARY KEY (id);

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.timeline_events TO anon;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.timeline_events TO authenticated;

GRANT MAINTAIN, REFERENCES, TRIGGER, TRUNCATE ON public.timeline_events TO service_role;

CREATE POLICY "Therapist Timeline Policy" ON public.timeline_events
  USING ((auth.role() = 'authenticated'::text));
