-- Nicotine Tracker: allow signed-in users to correct the time of their own records.
-- Safe to run once on an existing project. Does not delete or rewrite existing events.
grant update (smoked_at) on public.smoking_events to authenticated;

drop policy if exists "smoking_events_update_own" on public.smoking_events;
create policy "smoking_events_update_own"
  on public.smoking_events
  for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
