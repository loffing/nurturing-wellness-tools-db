-- Migration: Add fail-safe exception handling and search_path to handle_new_user trigger
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name)
  VALUES (
    new.id, 
    COALESCE(new.email, ''), 
    COALESCE(new.raw_user_meta_data->>'full_name', 'Clinical Practitioner')
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
EXCEPTION
  WHEN OTHERS THEN
    -- Prevent trigger errors from blocking user creation in auth.users
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;
