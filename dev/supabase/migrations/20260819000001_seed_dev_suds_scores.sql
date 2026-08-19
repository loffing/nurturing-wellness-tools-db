-- Migration: Update existing timeline events in DB so most (~75%) have SUDS ratings, but some remain NULL/unrated

WITH numbered_events AS (
  SELECT id, ROW_NUMBER() OVER (ORDER BY created_at, id) as row_num, category, impact_score
  FROM public.timeline_events
)
UPDATE public.timeline_events e
SET suds_score = CASE
  WHEN ne.category = 'Trauma' OR ne.impact_score <= -2 THEN 8
  WHEN ne.category = 'Family' OR ne.impact_score = -1 THEN 6
  WHEN ne.category = 'School' THEN 5
  WHEN ne.category = 'Clinical Intervention' THEN 3
  WHEN ne.category = 'Positive Milestone' OR ne.impact_score >= 2 THEN 2
  ELSE 4
END
FROM numbered_events ne
WHERE e.id = ne.id
  AND ne.row_num % 4 != 0;
