-- Migration: Grant table access and set RLS policies for authenticated users
GRANT ALL ON TABLE public.patients TO authenticated, anon;
GRANT ALL ON TABLE public.timeline_events TO authenticated, anon;
GRANT ALL ON TABLE public.practice_books TO authenticated, anon;
GRANT ALL ON TABLE public.profiles TO authenticated, anon;
GRANT ALL ON TABLE public.reading_lists TO authenticated, anon;

-- Permissive RLS policies for authenticated users
DROP POLICY IF EXISTS "Authenticated Patients Policy" ON public.patients;
CREATE POLICY "Authenticated Patients Policy" ON public.patients FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Authenticated Timeline Events Policy" ON public.timeline_events;
CREATE POLICY "Authenticated Timeline Events Policy" ON public.timeline_events FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Authenticated Practice Books Policy" ON public.practice_books;
CREATE POLICY "Authenticated Practice Books Policy" ON public.practice_books FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Authenticated Profiles Policy" ON public.profiles;
CREATE POLICY "Authenticated Profiles Policy" ON public.profiles FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Authenticated Reading Lists Policy" ON public.reading_lists;
CREATE POLICY "Authenticated Reading Lists Policy" ON public.reading_lists FOR ALL TO authenticated USING (true) WITH CHECK (true);
