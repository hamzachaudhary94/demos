# Riccardi Plumbing — Emergency Triage Demo, build reasoning

Client: Riccardi Plumbing (riccardiplumbing.com.au), Geelong, Australia.
Lane: Direct Clients, unsolicited free demo, LAW 36 / LAW 39 rules apply.

Hook used: their own homepage forces the exact same binary choice we are demoing —
"ARE YOU IN NEED OF EMERGENCY PLUMBING?" with CALL US NOW / GET A QUOTE buttons.
The demo proves their system can tell those two callers apart automatically when
nobody picks up, instead of every missed call getting the same generic voicemail.

## 10 ideas for "emergency vs non-emergency triage after a missed call"

1. **Split-screen parallel timelines** — both journeys animate side by side at once.
2. **Binary choice -> phone ring -> branching SMS response**, pacing and styling differ by branch (mirrors their real site's two buttons exactly).
3. **"Control room" dashboard** — a call comes in, gets tagged URGENT/STANDARD, routes through an animated flowchart.
4. **Generic chat-bubble simulator** — fake call notification then a message thread.
5. **Speedometer / gauge** — a needle counts down response time, emergency vs standard.
6. **Continuous drag-slider** from "leaky tap" to "burst pipe flooding", response morphs live.
7. **Static comic-strip storyboard** — three illustrated panels, no interaction.
8. **Before/after toggle** — OFF shows the old way losing the job, ON shows the new system.
9. **Voicemail transcript simulator** — AI "listens" to a fake voicemail, highlights urgency keywords, then reacts.
10. **Native phone-frame SMS mockup** — the branching texts render inside an iPhone-style frame graphic.

## Kills (7)

- **#1 split-screen** — killed. Shows a comparison chart, not a decision. The visitor never makes the choice themselves, so it proves nothing about THEIR call.
- **#3 control room dashboard** — killed. Shows us the software's internals, not what the customer on the other end of the phone actually experiences. Wrong audience for the demo.
- **#4 generic chat bubble** — killed. Redundant with #2/#10 but weaker, a plain chat bubble reads like a UI kit sample, not a real phone.
- **#5 speedometer/gauge** — killed on the brief's own bar: gimmicky, reads as a sales chart, does not show WHAT happens differently, only "faster."
- **#6 slider morph** — killed. Their real site is a hard binary (two buttons, not a dial), so a continuous slider invents a feature they don't have and undersells the actual mechanic.
- **#7 static comic panels** — killed. Not interactive, fails the spirit of "prove it works," reads as an illustration, not a demo of a system.
- **#8 before/after toggle** — killed. Answers a different question (old way vs new way), not emergency vs non-emergency. Off-brief.
- **#9 voicemail transcript with AI keyword highlighting** — killed. Compelling but two real risks: (a) harder to build reliably as clean static JS (typed-transcript timing), (b) implies a live AI voice/transcription capability that overclaims what's actually being demoed — same disease LAW 38 warns about, just in image form.

## Judged finalists (3): #2, #9, #10

| | Proves the triage distinction | Feels premium, not gimmicky | Reliable as static HTML/CSS/JS |
|---|---|---|---|
| **#2** binary choice -> ring -> branching response | Yes, directly — same choice as their site, two visibly different outcomes | Yes, if built as a real phone UI with proper pacing | Yes, plain timers and DOM, no fragile parts |
| **#9** voicemail transcript AI | Yes, but overclaims capability | Feels clever but risks reading as a fake AI claim | Medium, more moving parts, more that can look broken |
| **#10** phone-frame SMS mockup, standalone | Weak alone, it's a container not a mechanic | Yes, the visual is nice | Yes, trivial to build |

## Final pick

**#2, wearing #10's skin.** Build the binary-choice-to-ring-to-branching-SMS mechanic
(#2) and present the outcome inside a native phone frame with real SMS bubble styling
(#10's best trait), dropping #10 as its own separate concept since it had no mechanic
of its own. This is the only option that is a genuinely different mechanic from a
plain "ring then text" demo: the SAME missed call produces two measurably different
outcomes (timing, copy, visual urgency) depending on what the caller told the system,
which is exactly what LAW 53 requires — the observation (their own binary homepage
choice) and the proof (the demo reacting differently to each side of that choice)
are the same problem.

## What was built

Single file `index.html`. Visitor sees Riccardi's own question restated as an
interactive choice, picks a path, watches a phone ring and go unanswered, then
watches the auto-response differ:

- **Emergency path**: fast (~1.1s), red/urgent styling, pulsing "EMERGENCY" tag,
  offers the next available emergency slot today.
- **Standard path**: slower (~3.2s), calm/muted styling, offers a standard callback window.

A "try the other path" control lets them flip and compare both outcomes in one
sitting, which is the actual point being sold — not "we text back," but "we react
differently depending on what you tell us."

Accepts `?biz=<name>` (URL-decoded via `URLSearchParams`, defaults to
"Riccardi Plumbing") and injects it into the header and both SMS bodies via
`textContent` only, so it can be reused as a template without becoming an
injection risk.
