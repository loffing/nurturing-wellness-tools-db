-- Migration: Seed initial curated practice books and initial reading list
INSERT INTO public.practice_books (
  isbn, google_books_id, info_link, title, authors, cover_image, reading_level, maturity_age_min, maturity_age_max, clinical_topics, sensitivity_flags, gifted_kid_suitability, therapist_notes, parent_blurb
) VALUES 
(
  '9780970516596', '9s1EAAAAQAAJ', 'https://books.google.com/books?id=9s1EAAAAQAAJ', 'The Invisible String', ARRAY['Patrice Karst', 'Joanne Lew-Vriethoff'], 'https://m.media-amazon.com/images/I/81v5-bQO8xL._AC_UF1000,1000_QL80_.jpg', '1st-3rd Grade', 4, 8, ARRAY['Anxiety & Worry', 'Grief & Loss', 'Separation Anxiety', 'Family Transitions'], ARRAY['Mentions loss / missed loved ones'], 'Gentle emotional themes suitable for younger sensitive children', 'Classic story for separation anxiety and loss. Explores an invisible string of love connecting people no matter where they are.', 'A comforting picture book recommended by therapists to help children feel connected to parents during school drop-offs or after family changes.'
),
(
  '9780060284718', 'W3iV5qW4oVMC', 'https://books.google.com/books?id=W3iV5qW4oVMC', 'Wemberly Worried', ARRAY['Kevin Henkes'], 'https://m.media-amazon.com/images/I/71YyO5o+b4L._AC_UF1000,1000_QL80_.jpg', 'K-2nd Grade', 4, 7, ARRAY['Anxiety & Worry', 'School Transition', 'Social Anxiety'], ARRAY[]::text[], 'Relatable humor for observant and perfectionist early readers', 'Wemberly worries about big and small things before starting school. Great normalization of worry thoughts.', 'Helps young children recognize that feeling worried about new experiences is normal and manageable.'
),
(
  '9780316013697', 'pT58DwAAQBAJ', 'https://books.google.com/books?id=pT58DwAAQBAJ', 'The Fall of Freddie the Leaf', ARRAY['Leo Buscaglia'], 'https://m.media-amazon.com/images/I/81U27807p+L._AC_UF1000,1000_QL80_.jpg', '2nd-4th Grade', 6, 10, ARRAY['Grief & Loss', 'Life Transitions', 'Philosophical / Coping'], ARRAY['Direct allegory for death and life cycle'], 'Deep metaphorical narrative ideal for gifted children asking big questions about life and death', 'An allegory about a leaf changing with seasons and accepting the transition of autumn and winter.', 'A timeless story offering a gentle, natural metaphor for understanding change, loss, and the cycle of life.'
),
(
  '9781433805622', 'x6F3DwAAQBAJ', 'https://books.google.com/books?id=x6F3DwAAQBAJ', 'What to Do When You Worry Too Much', ARRAY['Dawn Huebner', 'Bonnie Matthews'], 'https://m.media-amazon.com/images/I/81XmJz5-4cL._AC_UF1000,1000_QL80_.jpg', '3rd-6th Grade', 6, 12, ARRAY['Anxiety & Worry', 'Emotion Regulation', 'CBT Workbook'], ARRAY[]::text[], 'Interactive workbook structure highly engaging for analytical young minds', 'CBT-based workbook for children and parents. Teaches ''worry logic'' and concrete exposure/calming tools.', 'An interactive workbook designed to empower kids with evidence-based cognitive behavioral techniques to manage anxiety.'
),
(
  '9780385737951', '4g31DwAAQBAJ', 'https://books.google.com/books?id=4g31DwAAQBAJ', 'The Girl Who Never Made Mistakes', ARRAY['Mark Pett', 'Gary Rubinstein'], 'https://m.media-amazon.com/images/I/71R2l1u-97L._AC_UF1000,1000_QL80_.jpg', '1st-4th Grade', 5, 9, ARRAY['Perfectionism', 'Anxiety & Worry', 'Self-Compassion'], ARRAY[]::text[], 'Directly addresses perfectionism common in academically gifted children', 'Beatrice never makes mistakes until one day she does publicly. Shows how humor and self-compassion free us from perfectionism.', 'A lighthearted story ideal for high-achieving children who struggle with fear of making mistakes.'
),
(
  '9781501144981', 'mZg0EAAAQBAJ', 'https://books.google.com/books?id=mZg0EAAAQBAJ', 'My Body Sends a Signal', ARRAY['Natalia Maguire'], 'https://m.media-amazon.com/images/I/71e-K17g-nL._AC_UF1000,1000_QL80_.jpg', 'PreK-2nd Grade', 4, 7, ARRAY['Emotion Regulation', 'Somatic Awareness', 'Neurodiversity'], ARRAY[]::text[], 'Teaches body listening skills for kids who over-intellectualize feelings', 'Helps children link physical body sensations (racing heart, tight fists) with emotional states.', 'Teaches children to recognize physical signals in their body as clues to their emotions before meltdowns occur.'
),
(
  '9780142403877', 'm9eFBAAAQBAJ', 'https://books.google.com/books?id=m9eFBAAAQBAJ', 'Fish in a Tree', ARRAY['Lynda Mullaly Hunt'], 'https://m.media-amazon.com/images/I/71Q1A5JpGQL._AC_UF1000,1000_QL80_.jpg', '4th-7th Grade', 9, 13, ARRAY['Neurodiversity', 'Self-Esteem', 'School Transition', 'ADHD / Dyslexia'], ARRAY['Bullying mentions'], 'High reading complexity; celebrates non-linear thinkers and twice-exceptional (2e) students', 'Ally hides her dyslexia behind disruptive behavior until a teacher recognizes her unique brilliance.', 'An inspiring novel for middle-grade readers exploring neurodiversity, self-acceptance, and hidden intelligence.'
),
(
  '9781433808166', '5r93DwAAQBAJ', 'https://books.google.com/books?id=5r93DwAAQBAJ', 'What to Do When Your Temper Flares', ARRAY['Dawn Huebner'], 'https://m.media-amazon.com/images/I/81xUe3O-UYL._AC_UF1000,1000_QL80_.jpg', '3rd-6th Grade', 6, 11, ARRAY['Anger Management', 'Emotion Regulation', 'CBT Workbook'], ARRAY[]::text[], 'Structured strategies for children with intense emotional responses', 'Guides children through anger-extinguishing techniques, cognitive reframing, and cool-down breaks.', 'Offers practical CBT tools for parents and children to manage anger outbursts constructively.'
),
(
  '9780064407311', 'gH73DwAAQBAJ', 'https://books.google.com/books?id=gH73DwAAQBAJ', 'Bridge to Terabithia', ARRAY['Katherine Paterson'], 'https://m.media-amazon.com/images/I/81b9kLhZzAL._AC_UF1000,1000_QL80_.jpg', '5th-8th Grade', 10, 14, ARRAY['Grief & Loss', 'Friendship & Identity', 'Imagination'], ARRAY['Sudden accidental death of a peer/friend'], 'Advanced literary classic for mature middle schoolers processing grief', 'Deep exploration of peer friendship and sudden traumatic loss. Best recommended with therapist/parent guidance.', 'A beloved classic exploring imagination, deep friendship, and navigating unexpected loss.'
),
(
  '9781534439160', 'JcevDwAAQBAJ', 'https://books.google.com/books?id=JcevDwAAQBAJ', 'The Boy, the Mole, the Fox and the Horse', ARRAY['Charlie Mackesy'], 'https://m.media-amazon.com/images/I/81wgcld4xhL._AC_UF1000,1000_QL80_.jpg', 'All Ages / 2nd-12th', 6, 99, ARRAY['Self-Compassion', 'Mental Health Awareness', 'Vulnerability', 'Hope'], ARRAY[]::text[], 'Profound philosophical reflections accessible to all reading levels', 'Beautifully illustrated dialogue on kindness, asking for help, and inner courage.', 'A gentle, poignant book for all ages about kindness, hope, and the courage to reach out for help.'
)
ON CONFLICT DO NOTHING;

-- Seed default initial reading list linked to saved books
INSERT INTO public.reading_lists (title, description, book_ids)
SELECT 
  'Childhood Anxiety & Coping',
  'Recommended therapeutic literature for clients working through worry box strategies and somatic grounding.',
  ARRAY_AGG(id::text)
FROM public.practice_books
WHERE title IN ('The Invisible String', 'Wemberly Worried', 'What to Do When You Worry Too Much')
ON CONFLICT DO NOTHING;

-- Reload PostgREST schema cache
NOTIFY pgrst, 'reload schema';
