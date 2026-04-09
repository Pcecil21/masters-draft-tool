# Masters Draft Tool — Expansion Plan

Reviewed 2026-04-08. Full CEO-mode EXPANSION review completed. Implementation tabled until post-Masters 2026.

## Priority Implementations (for 2027 season)

| # | Task | Effort | Status |
|---|---|---|---|
| 1 | Extract `golfers.js` + `YEAR` constant | 15 min | DONE |
| 2 | Delete `masters-draft.html` | 1 min | DONE |
| 3 | Add `owner_secret` column + RLS lockdown | 30 min | DONE |
| 4 | Admin URL with owner key recovery | 20 min | DONE |
| 5 | Switch viewers to Supabase Realtime (not polling) | 30 min | DONE |
| 6 | Reconnect logic + 3-state sync indicator | 25 min | DONE |
| 7 | `esc()` XSS helper on all name interpolations | 10 min | DONE |
| 8 | Extract `replayHistory()` (DRY) | 10 min | DONE |
| 9 | Wire tracker.html to Supabase via `?pool=` | 45 min | DONE |
| 10 | Clipboard fallback + pool ID collision check | 10 min | DONE |
| 11 | Draft recap / share card (build after all picks) | 25 min | DONE |
| 12 | Auto-scroll to next best available after each pick | 10 min | DONE |
| 13 | Last pick toast notification (viewers see it too) | 15 min | DONE |
| 14 | Create TESTING.md + deploy freeze policy | 10 min | DONE |
| 15 | Redeploy to Vercel | 1 min | READY |

## Delight Items (TODOS)

- **On the Clock indicator** — animated pulse on current drafter's name in sidebar
- **Pick sound effect** — golf clap or thwack audio on confirmed pick, viewers hear it via Realtime

## Key Architecture Decisions (resolved)

- Supabase Realtime over 10s polling for viewer updates
- Owner secret in admin URL (not password-based auth)
- RLS policies locked to owner_secret via custom header
- Shared golfers.js (single source of truth, not duplicated)
- tracker.html reads from Supabase same as draft tool
- YEAR constant for easy annual refresh
- HTML entity escaping on all user-input names
- Deploy freeze: all changes done day before draft

## Supabase Details

- Project: Home Grown Hockey (`bbjwssziyytnmtwarfbh`)
- Table: `draft_pools` (pool_id, state, updated_at)
- Migration: `supabase-migration.sql` (run before deploy) — adds owner_secret, scores columns + RLS + Realtime
