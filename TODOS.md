# Masters Draft Tool — Expansion Plan

Reviewed 2026-04-08. Full CEO-mode EXPANSION review completed. Implementation tabled until post-Masters 2026.

## Priority Implementations (for 2027 season)

| # | Task | Effort | Status |
|---|---|---|---|
| 1 | Extract `golfers.js` + `YEAR` constant | 15 min | TODO |
| 2 | Delete `masters-draft.html` | 1 min | TODO |
| 3 | Add `owner_secret` column + RLS lockdown | 30 min | TODO |
| 4 | Admin URL with owner key recovery | 20 min | TODO |
| 5 | Switch viewers to Supabase Realtime (not polling) | 30 min | TODO |
| 6 | Reconnect logic + 3-state sync indicator | 25 min | TODO |
| 7 | `esc()` XSS helper on all name interpolations | 10 min | TODO |
| 8 | Extract `replayHistory()` (DRY) | 10 min | TODO |
| 9 | Wire tracker.html to Supabase via `?pool=` | 45 min | TODO |
| 10 | Clipboard fallback + pool ID collision check | 10 min | TODO |
| 11 | Draft recap / share card (build after all picks) | 25 min | TODO |
| 12 | Auto-scroll to next best available after each pick | 10 min | TODO |
| 13 | Last pick toast notification (viewers see it too) | 15 min | TODO |
| 14 | Create TESTING.md + deploy freeze policy | 10 min | TODO |
| 15 | Redeploy to Vercel | 1 min | TODO |

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
- Needs: ALTER to add `owner_secret` text column, `scores` jsonb column
