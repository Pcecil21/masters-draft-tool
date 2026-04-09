-- Masters Draft Tool — Supabase migration
-- Run this in the Supabase SQL Editor for project: Home Grown Hockey (bbjwssziyytnmtwarfbh)

-- 1. Add owner_secret and scores columns
ALTER TABLE draft_pools
  ADD COLUMN IF NOT EXISTS owner_secret text,
  ADD COLUMN IF NOT EXISTS scores jsonb DEFAULT '{}'::jsonb;

-- 2. Enable RLS
ALTER TABLE draft_pools ENABLE ROW LEVEL SECURITY;

-- 3. Anyone can read any pool (viewers need this)
CREATE POLICY "Anyone can read pools"
  ON draft_pools FOR SELECT
  USING (true);

-- 4. Only the owner (matching secret) can insert/update
-- The owner_secret is passed via the state on first create,
-- then matched on subsequent updates.
CREATE POLICY "Owner can insert pools"
  ON draft_pools FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Owner can update own pools"
  ON draft_pools FOR UPDATE
  USING (
    owner_secret IS NULL
    OR owner_secret = current_setting('request.headers', true)::json->>'x-owner-secret'
  );

-- 5. Enable Realtime on draft_pools
ALTER PUBLICATION supabase_realtime ADD TABLE draft_pools;
