---
layout: post
title: "Building Fluid Scroll-Wheel Pickers for Home Assistant"
description: "Two dependency-free Lovelace cards - a time picker and a number picker - with a native, momentum-scroll wheel UI."
comments: false
keywords: "home assistant, lovelace, hacs, web components, time picker, number picker"
---

I've spent a chunk of the last few days rebuilding two Lovelace cards for Home Assistant: a time picker and a number picker. Both started life as small, useful custom cards, and both ended up as ground-up, dependency-free rewrites with a UI I actually enjoy using. Here's the story of what they do, what changed, and a few of the uglier bugs I ran into along the way.

## Why bother rewriting a time picker?

Home Assistant's native `input_datetime` controls are functional but plain - a text field, or a set of up/down steppers. [GeorgeSG's original `lovelace-time-picker-card`](https://github.com/GeorgeSG/lovelace-time-picker-card) improved on that with arrow-stepper controls for hour, minute, and second. It's a solid card, and full credit to Georgi for the original design - but I wanted something that felt more like the native iOS/Android time picker: a wheel you flick, that settles with momentum, that feels alive under your thumb.

So I forked it and rewrote the whole thing from scratch as **[lovelace-time-picker-card v2](https://github.com/dwainegallimore/lovelace-time-picker-card)** - no `lit`, no `custom-card-helpers`, no runtime dependencies at all. Just a small native Web Component, native scroll + CSS scroll-snap for the wheel physics, and a bit of JavaScript to handle the circular wraparound (so the hour wheel loops smoothly from 23 back to 0 instead of hitting a wall).

### What it looks like now

The wheel collapses down to a single row when you're not touching it, and expands to show its neighbors the moment you interact with it:

![Idle, collapsed to a single row](/assets/images/lovelace-pickers/idle-collapsed.png)

12-hour mode adds an AM/PM pill toggle next to the wheel:

![12-hour mode with the AM/PM toggle](/assets/images/lovelace-pickers/12-hour-ampm.png)

Tap or drag a wheel and it expands, showing the values above and below the one you're on - exactly like a real mechanical picker:

![Mid-scroll, showing neighboring values](/assets/images/lovelace-pickers/wheel-interaction.png)

And because it's built to be embeddable, you can stack a start/end pair side by side without either one carrying its own card chrome:

![Two embedded cards stacked side by side](/assets/images/lovelace-pickers/embedded-pair.png)

The visual editor got the same attention - box-style controls instead of dropdowns and sliders scattered across a dozen rows, sensible grouping, and no more layout skew from Home Assistant's own entity picker throwing the column widths off.

![Visual editor](/assets/images/lovelace-pickers/editor.png)

## And then, a number picker

Partway through polishing the time picker, it became obvious the same wheel mechanic would work nicely for plain numeric values too - target temperatures, volume levels, price thresholds, anything backed by an `input_number` entity. Rather than bolt that onto the time picker's codebase, I built it as its own project: **[lovelace-number-picker-card](https://github.com/dwainegallimore/lovelace-number-picker-card)**.

It's deliberately the smaller, simpler sibling: one linear wheel instead of an hour/minute/second trio, no circular wraparound needed (a number has real endpoints), but the same fluid scroll feel, the same dependency-free Web Component approach, and an editor built the right way from day one - I'd already learned the hard lessons building the time picker's editor, so this one skipped straight past them.

```yaml
type: 'custom:number-picker-card'
entity: input_number.target_temperature
min: 16
max: 28
step: 0.5
unit_of_measurement: '°C'
```

By default it just reads `min`, `max`, and `step` straight off the entity, so most of the time you don't need to configure anything beyond which entity to point it at.

## The bugs worth mentioning

Neither of these shipped clean on the first try, and a couple of the bugs were genuinely interesting - the kind where the fix looks obvious in hindsight but the symptom was thoroughly confusing at the time.

**The wheel that lied about where it was.** After shipping, I got a report that a time picker would occasionally reset to `00:00` on page refresh, even though the underlying entity had the correct time the whole time. Tracing it down took a few rounds of browser-console diagnostics (I ended up writing small scripts to walk the shadow DOM and compare the card's internal state against the real entity state, layer by layer). The eventual root cause: if a wheel gets built while its container has zero height - a hidden dashboard tab, a card inside a not-yet-sized grid cell - the browser silently clamps `scrollTop` to `0` and never revisits it. The wheel's own bookkeeping thought it was showing the right value; the pixels disagreed. The fix was a `ResizeObserver` that catches the wheel up the moment it actually gets laid out, plus a second pass making `setValue()` verify the wheel is actually where it claims to be rather than trusting its own state blindly.

**The clipped negative number.** A much simpler one, but a good reminder that "looks fine in testing" doesn't mean "looks fine for every input": the number wheel had a fixed CSS width sized for values like `50`, and a longer value like `-20.0` got clipped mid-character. Now the wheel measures its own widest possible value and sizes itself to fit, instead of guessing.

**The wheel that outgrew its own card.** A more recent one: expanding a wheel to show its neighbors grows it from 44px tall to 132px, but `ha-card` was capped at `height: 100%` with `overflow: hidden` - fine as long as the surrounding dashboard grid cell happened to already be tall enough, but silently invisible the moment it wasn't (a narrow horizontal stack of two cards was the report that caught it). Swapping to `min-height: 100%` with `overflow: visible` let the card keep filling its given space without capping how far the expanded wheel is allowed to grow past it.

Between them, these are the kind of bugs a quick glance at the code won't catch - they only show up when you actually drive the thing in a browser and watch what the DOM does, not just what the code says it should do.

## Try them

Both cards install the same way, via [HACS](https://hacs.xyz) or manually by dropping the built JS into `config/www`:

- **Time picker:** [github.com/dwainegallimore/lovelace-time-picker-card](https://github.com/dwainegallimore/lovelace-time-picker-card)
- **Number picker:** [github.com/dwainegallimore/lovelace-number-picker-card](https://github.com/dwainegallimore/lovelace-number-picker-card)

Both READMEs have the full config reference, theme variables, and more examples than I could reasonably fit in this post. If you spot a rough edge, open an issue - between the two of these I've already found more bugs than I expected to, and I'd rather hear about the next one than have it sit there quietly.
