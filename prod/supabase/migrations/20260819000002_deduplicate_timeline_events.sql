-- Migration: Clean up duplicate timeline events in DB (keeping the earliest created record per unique event)

DELETE FROM public.timeline_events a
USING public.timeline_events b
WHERE a.id > b.id
  AND a.patient_id = b.patient_id
  AND LOWER(TRIM(a.title)) = LOWER(TRIM(b.title))
  AND a.event_date = b.event_date
  AND a.category = b.category;
