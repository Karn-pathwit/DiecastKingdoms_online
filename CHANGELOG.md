# Diecast Kingdoms Changelog

## V2.1.0 — Halloween game challenge and usability

- Removed the simultaneous-ghost cap and the nine-enemy wave ceiling. Waves now scale upward, spawn intervals shorten from 1.30 seconds by 0.09 seconds per wave to a 0.34-second floor, and the pause between waves is removed.
- Reworked waves 1–5 into a slower warm-up with a total of 37 ghosts, giving players time to learn and collect spirit energy before wave 6.
- Ensured rune symbols do not repeat within one ghost; added a boss-only closed-circle O rune for the Pret and taught the game to recognize it.
- Added an x2 speed toggle, a prominent current-score display, a smaller-but-clearer COMBO counter, and a compact live top-three board with projected Top 8 / first-place score gaps. Combo 100+ triggers a blue neon Overdrive glow.
- Expanded spirit energy to 100 and added a hold-still-for-0.8s recovery spell that restores one candle up to the three-candle limit, with a visible charge ring; the existing 30/50 double-tap spells remain unchanged.
- Enlarged the ward candles, repositioning them on portrait screens to avoid the spell panel.
- Changed the pause-menu exit action to end the run, submit its score, and show the score summary without waiting for all three candles to go out.

## V2.0.1 — Halloween 2026 fixes

- Corrected the season label to 2026 and removed the temporary Level 5 Evolution map badge while keeping the Blankheimgard POPBOSS congratulations badge.
- Fixed the minigame's case-sensitive asset paths so the supplied cemetery background and illustrated ghost sprites load on GitHub Pages.
- Restored the original humorous Casteria, Blankheimgard, Machinepolis, and Finalthron sect names, and added Bascentra as “สำนักมณีปราบผี”. Scores continue to store canonical kingdom names for the database.

## V2.0.0 — Halloween 2026

- Activated Halloween world map videos and the single-track “เทศกาลผีน้อยเริงร่า” playlist from 27 September through 30 October 2026, Bangkok time. The normal day/night videos and five-song playlist return at 00:00 on 31 October; 31 October is reserved for score review and winner recognition.
- Replaced the POPBOSS event screen with “หมอผีซ่าส์ กับ วิญญาณอลเวง”, a solo-score game with a shared top-eight leaderboard. The highest score per employee is kept; rank 1 is the event winner.
- Added all five kingdoms to the game. Blankheimgard keeps its POPBOSS champion privilege: one free screen-clearing frost power at the start of each run.
- Added the POPBOSS champion trophy to Blankheimgard.
- Added the “เรารักพี่อ๋อง” city-entry password.
- Added server-timestamped project event history, submission/evidence dates in detail views, and timeline/date columns in CSV exports. Existing UPDATED behavior remains unchanged.
- Replaced the normal night background videos with the supplied landscape and portrait clips.
- Added a seven-day POPBOSS results announcement starting 27 September with ranked, highlighted kingdom scores and the last four score digits masked. Added a champion badge beside Blankheimgard that opens a council letter and its trophy in the island's hall of fame.
- The Halloween minigame leaderboard displays the employee IDs entered by players, as requested. These IDs are visible to all site visitors.

### Supabase setup required

Before publishing this version, run [`supabase_v200_upgrade.sql`](supabase_v200_upgrade.sql) once in the Supabase SQL Editor. It creates the project event log and the private score table/RPCs used by the shared Halloween leaderboard. The existing `popboss_scores` table is not dropped.
