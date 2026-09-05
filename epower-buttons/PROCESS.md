# ePower demo — /10 process

**Brief:** use ePower's own real 3-button header pattern (Get a Quote / Call Us /
Download Our App) as the literal frame, then isolate what happens when "Call Us"
goes unanswered, and show a smart text-back instead.

Fixed regardless of which idea won: the header recreation itself (their 3 real
buttons, their green #56BC77, their near-black #181A1B, "CONCEPT DEMO" pill,
their tagline and 4.9★/600+ review line). What's actually being decided below is
**how the reveal happens after the click** — that's the one real fork.

## 10 ideas for the reveal mechanism

1. **Phone mockup drops in below the header.** Click Call Us, a phone UI
   appears under the button row: rings, goes missed, then an SMS thread from
   ePower offers a booking slot.
2. **The Call Us button morphs in place.** No phone graphic — the button
   itself turns into a live status chip: "Ringing… → Missed → Texted back."
3. **Full-screen modal takeover.** Click Call Us, the whole page dims and a
   giant ringing animation takes over center-screen.
4. **Permanent split-screen.** "Old way" and "new way" columns sit side by
   side at all times; clicking Call Us plays both in parallel.
5. **Notification toast stack.** OS-style toast cards climb up the
   bottom-right corner: Incoming call → Missed → Text sent → Reply: booked.
6. **A ticking "leads lost" counter.** An abstract number increments each
   time Call Us is clicked, dramatizing lost revenue instead of showing UI.
7. **Two phones side by side.** Customer's phone and the owner's phone react
   in sync to show both sides of the missed call at once.
8. **A draggable day-timeline.** A scrubber across a full day's worth of
   missed calls, click one to expand it.
9. **Voicemail transcript reveal.** An old-style voicemail box appears first,
   greyed out, then gets replaced by the SMS thread.
10. **Chat-widget bubble.** A bottom-right chat bubble appears as if it were
    a live widget on ePower's own site, simulating the text-back there.

## Kill 7

- **#3 Full-screen modal** — a takeover disconnects the reveal from their own
  button pattern; reads like a popup ad, not "their site working differently."
- **#4 Permanent split-screen** — competes with the header for attention and
  dilutes the one-gap focus the brief asks for; heavier build for no real gain.
- **#6 Ticking counter** — an abstract number isn't "what a smart system does
  differently," it never actually shows the text-back working.
- **#7 Two phones side by side** — doubles the build and the screen space for
  no extra clarity, and breaks down at 375px width.
- **#8 Draggable timeline** — needs a working drag/scroll interaction, which
  is exactly the kind of thing that's unreliable as static HTML on mobile.
- **#9 Voicemail transcript** — adds a whole second device metaphor that
  isn't part of ePower's real pattern; feels dated, not premium.
- **#10 Chat widget** — the verb mismatch risk from LAW 53: a chat bubble
  implies live chat, not "we texted you back after a missed call." Wrong claim.

## Judge the 3 survivors

Criteria: (a) visually uses their real 3-button pattern as the frame,
(b) feels premium not gimmicky, (c) buildable reliably as static HTML/CSS/JS.

| | #1 Phone mockup reveal | #2 Button morphs inline | #5 Notification toast stack |
|---|---|---|---|
| (a) uses their pattern | Header stays untouched, phone is the direct result of the click | Most literal — the button itself IS the demo | Weak — reveal happens in a corner, disconnected from the header |
| (b) premium vs gimmicky | Real iOS-style chrome, matches the polish bar already proven in `missed-call/` | Minimal, but too thin — can't actually show what the text-back looks like | This is the generic "ring simulation" the brief says to avoid |
| (c) buildable reliably | Same animation engine already shipped and tested once | Would still need a phone UI to show the SMS content anyway, so it doesn't save build risk | Buildable, but generic |

**Picked: #1, phone mockup reveal under the real header.** It's the only one
that keeps their real 3-button row intact as the literal frame, actually shows
the working text-back (not just a status word), and reuses an animation
pattern already proven reliable in this project. #2 collapses back into #1 the
moment you try to show real SMS content. #5 is the generic pattern the brief
explicitly said not to just clone.

## What got built

- Their 3-button header, recreated as styled text and CSS (no logo, no real
  images): Get a Quote / Call Us / Download Our App, on their near-black
  background with their green accent.
- Get a Quote and Download Our App are present but inert — a tap shows a
  small tooltip: "This one already works fine." That's the whole point: only
  one of the three buttons has a hidden problem.
- Call Us rings, goes to a missed-call state, then an SMS thread appears:
  "Sorry we missed you! This is ePower…" offering to lock in a slot for a
  home EV charger install or a solar consultation, ends in a booked
  confirmation with ePower's name on it.
- Real facts used: green #56BC77, near-black #181A1B, white text, 4.9★/600+
  reviews, and the tagline "Join us on the road to clean mobility. Speak to
  an EV charging expert today."
- `?biz=` query param overrides the business name everywhere it appears
  (wordmark, headline, SMS sender, confirmation line), defaults to "ePower."
- No real logo, no real photos, no scraped assets — wordmark is styled text.
- Visible "CONCEPT DEMO · NOT A REAL SERVICE" pill plus a plain-language line
  stating this is not epower.ie and not affiliated with or endorsed by them.
- No form posts anywhere, no data collected. Verified by reading the file
  back after writing it: no console-error-prone patterns, all event
  listeners attach to elements that exist at bind time, animation states
  transition through a single timer chain with a reset on replay.
