# Masters Draft Tool — Testing Guide

## Pre-Draft Checklist

1. **Pool creation** — Open `index.html`, tap POOL, add 2+ names, set draft order, confirm. Verify:
   - Pool code appears in header bar
   - URL updates with `?pool=XXXXXX&key=...`
   - Admin link copies correctly (includes key)
   - Viewer link copies correctly (no key)

2. **Viewer sync** — Open the viewer URL (no `key` param) in a second tab/device. Verify:
   - Owner-only controls are hidden (POOL, UNDO, RESET, ADMIN LINK)
   - Sync indicator shows green "Synced"
   - Making a pick in the owner tab updates the viewer in real-time (no refresh needed)
   - Toast notification appears on viewer when a pick is made

3. **Draft flow** — Run a full mock draft (2-3 teams, 3 rounds). Verify:
   - Snake order works correctly (round 2 reverses)
   - Pick badge updates with current drafter name
   - Ticker shows last 10 picks
   - Board auto-scrolls to next best available
   - Draft recap overlay appears after final pick
   - Recap copy-to-clipboard works

4. **Tracker** — Open `tracker.html?pool=XXXXXX`. Verify:
   - Teams and golfer picks load from Supabase
   - Leaderboard view works
   - ESPN fetch works (during tournament)

5. **Admin recovery** — Copy admin URL, clear localStorage, paste admin URL. Verify owner controls return.

6. **Mobile** — Test all above on phone-sized viewport. Tabs, overlays, and board should be usable.

## Deploy Freeze Policy

- **All changes must be committed and deployed by the day before the draft.**
- No code changes on draft day unless fixing a critical bug.
- After deploying, do a full run-through of the Pre-Draft Checklist on the production URL.
- Keep a local backup of `golfers.js` in case Vercel goes down — the tool can run as a local file.

## Supabase Migration

Before first deploy, run `supabase-migration.sql` in the Supabase SQL Editor:
- Adds `owner_secret` and `scores` columns
- Enables RLS policies
- Enables Realtime on `draft_pools`
