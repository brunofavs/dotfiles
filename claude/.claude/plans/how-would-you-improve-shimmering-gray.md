# Plan: Improve writing-humanized for scientific/research writing (default)

## Context

The current `writing-humanized` skill applies a general anti-AI-slop editing pass tuned for blog and opinion writing. Since the user writes scientific text roughly 95% of the time, the current defaults actively hurt most of their real use cases:

- **"Personality and Soul"** tells the model to add first-person opinions, tangents, and mixed feelings. In a paper, that's wrong: formal register, third-person or "we", no editorializing.
- **Passive voice** is flagged for rewriting, but Methods/Results sections in most venues prefer or require it ("Samples were collected", "The controller was trained for 10 epochs").
- **"Excessive hedging"** is flagged, but scientific writing *needs* epistemic hedges ("may", "suggests", "consistent with", "we hypothesize") to accurately reflect uncertainty.
- **Rule of three** is often structurally correct in papers (three baselines, three benchmarks, three metrics).
- Some vocabulary on the blocklist ("highlight", "underscore", "key") appears legitimately in scientific prose.

At the same time, the skill misses scientific-specific AI tells: bare "novel", "state-of-the-art" without comparison, "extensive experiments demonstrate", "leverage" as verb, empty motivation openings ("In recent years, X has seen remarkable progress"), and generic contribution bullets.

**Goal**: make scientific/academic writing the *default* mode. The casual/opinion-style rewriting the current skill does is preserved but demoted to an opt-in mode that only fires when the user explicitly asks for it (or when the input is obviously casual).

## Design

One file to modify: `/home/bruno/.claude/skills/writing-humanized/SKILL.md`.

Changes stay in the main SKILL.md (no references/ split, no separate scientific skill). Scope is general scientific writing; robotics-specific patterns are out of scope per user choice.

### 1. Update the frontmatter description

The description should signal that scientific/academic writing is the default target so the skill triggers correctly on paper drafts, abstracts, and technical prose without the user having to say "academic style".

New description (approximate): "Rewrite, rephrase, or revise text so it sounds natural and human, stripping AI writing tells. Defaults to formal scientific and academic register (papers, abstracts, methods, related work) since that's the common case. Use whenever the user asks to rewrite, rephrase, revise, edit, improve, or clean up text. Casual or opinion-style rewriting only when the user explicitly asks."

### 2. Add a "Default: Scientific/Academic Register" block near the top

Insert right after "Voice Calibration". This block sets expectations for the whole skill:

- Assume the input is scientific/technical writing (paper draft, abstract, methods, related work, thesis chapter, grant proposal, technical report) unless the user says otherwise.
- Maintain formal register: third-person or first-person plural "we". No first-person singular opinions. No tangents, self-corrections, or emotional reactions.
- Preserve the *voice of published work in the field*: even rhythm, precise diction, defensible claims.
- Only switch to casual/opinion mode when one of these applies:
  - The user explicitly says so ("make this casual", "blog style", "with more voice", "add personality", "opinion piece").
  - The input has clear casual signals: first-person singular opinions already present, no citations or section markers anywhere, informal vocabulary, personal narrative.

### 3. Rewrite the rule set as the scientific default

The existing sections stay, but their guidance is adjusted so scientific writing is what the skill produces by default. Concretely:

**Rules that stay unchanged**: em dashes and en dashes (§13), boldface (§14), inline-header bullets (§15), emojis (§16), sycophantic openers (§17), filler phrases (§18), generic positive conclusions (§20), persuasive authority openers (§21), signposting announcements (§22), conversational rhetorical openers (§23), staccato drama (§24), aphorism formulas (§25), significance inflation (§1), vague attributions (§2), superficial -ing endings (§3), promotional language (§4), false ranges (§11), elegant variation (§10). These fire the same way regardless of register.

**Rules that get scientific-default adjustments (in place):**

- **§6 AI vocabulary overuse** — split the blocklist. Always cut: delve, tapestry, landscape (abstract), vibrant, testament, fostering, garner, intricate, pivotal. Allowed in scientific context: highlight (verb), underscore (verb), key (adjective) when modifying a real technical noun, valuable when comparative.
- **§7 Copula avoidance** — allow "serves as" and "represents" when precise ("This dataset serves as a testbed for X", "F represents the reward function"). Still cut "boasts", "showcases".
- **§9 Rule of three** — only flag when the three items are decorative (parallel padding). Three real items (three baselines, three benchmarks, three ablations) stay.
- **§12 Passive voice** — allow in Methods and Results sections. Prefer active in Introduction and Discussion but do not rewrite passive that is venue-conventional. Still fix subjectless fragments like "No configuration needed."
- **§19 Excessive hedging** — preserve epistemic hedges ("may", "might", "suggests", "consistent with", "we hypothesize", "appears to", "under the assumption that"). Only cut *stacked* hedges ("could potentially possibly", "may perhaps arguably").
- **§26 Hyphenated compounds in predicate position** — keep the current rule; scientific writing follows the same convention.

**Rules that get demoted to opt-in mode**:

- **"Personality and Soul"** section — move to a new "Opt-in: Casual / Opinion Register" section (see below). Only apply when the user explicitly asks or when input is clearly casual.
- **"What NOT to change" § 'Mixed feelings' and 'first-person editorial asides'** — these signals of a real human writer are opt-in-mode only. In scientific default, first-person singular asides get cut.

### 4. Add scientific-specific AI tells (new subsection under the rule set)

New numbered subsection: "AI tells specific to scientific/academic writing". Actively catch and rewrite these:

- **Empty motivation openings** — "In recent years, X has seen remarkable progress", "X has emerged as a critical area of research", "Recent advances in X have led to..." → cut and start with a specific claim.
- **Overclaimed novelty** — bare "novel", "novel framework", "novel approach" without saying *what* is new. Require the sentence to state the specific new contribution.
- **"State-of-the-art" as bare claim** — "achieves state-of-the-art performance", "SOTA results" without naming the benchmark or the number → require the concrete comparison.
- **Hype adjectives on evaluations** — "extensive experiments", "comprehensive analysis", "thorough evaluation" → cut the hype word; report what was actually run.
- **"Outperforms existing methods"** → require an actual number and the specific baseline. "Outperforms X by 4.2 accuracy points on Y" not "outperforms existing methods".
- **"To the best of our knowledge, this is the first"** → almost always overclaim. Only keep if genuinely defensible; otherwise soften ("we are not aware of prior work that...").
- **"Leverage" as verb** — replace with "use", "apply", "adapt", or a more specific verb.
- **"Seamlessly integrate", "paradigm shift", "holistic approach"** — remove; state what the integration or approach concretely is.
- **"Bridge the gap"** — remove; say what specifically the work does that prior work did not.
- **Generic contribution bullets** — bullets that could describe *any* paper ("We propose a novel method", "We conduct extensive experiments", "We show significant improvement") → rewrite so each bullet names something only *this* paper contains.
- **Vague comparators** — "significantly better", "much faster", "considerably more efficient" without numbers → require numbers or effect sizes.

### 5. Add a numerical-specificity rule

Short new rule: any claim of improvement, superiority, or scale must include a number. If the input claims a result without a number, either:

- Preserve the claim but flag it in the audit as "needs a specific figure the author must supply".
- Or rewrite more modestly if the honest scope is clear from the input.

Never invent numbers.

### 6. Add a structural-preservation rule

Short new rule:

- Do not reorder canonical sections (Abstract, Introduction, Related Work, Method, Experiments, Discussion, Conclusion).
- Preserve first-person plural "we" as the default subject; do not switch to first-person singular.
- Preserve legitimate signposting in Discussion sections ("Section 3 describes...", "First, we find that...") — this is distinct from the general skill's ban on "Let's dive in" style announcements.
- Preserve defined symbols, notation, and mathematical statements exactly.

### 7. Move "Personality and Soul" to an opt-in section

Rename to "Opt-in: Casual / Opinion Register" and move to the bottom of the skill, before PROCESS. Add an explicit trigger note at the top of it:

- Only apply this section when the user says something like "make this casual", "blog style", "add voice", "opinion piece", "less formal", or when the input has clear casual signals (first-person singular opinions, no citations, informal vocabulary, personal narrative).
- Otherwise, stay in the scientific default.

Everything currently in "Personality and Soul" stays in this section unchanged.

### 8. Update the PROCESS section

Replace step 1 with two lines:

- 1a. Determine register: scientific (default) or casual/opinion (only if the user explicitly asks or the input is clearly casual).
- 1b. Read the input and identify AI patterns present, applying the register-specific rules.

The rest of PROCESS (draft, audit, final) stays the same. In the audit note, briefly state which register was used and why.

## Files to modify

- `/home/bruno/.claude/skills/writing-humanized/SKILL.md` — additions and reorganization; no rules are deleted. The "Personality and Soul" section is moved and gated, not removed. Length grows from ~187 lines to roughly ~280 lines, comfortably under the 500-line soft cap.

The description in the frontmatter is updated so the skill's trigger criteria signal scientific-default behavior.

## Verification

Test the updated skill on three representative inputs and confirm the default is scientific:

1. **Paper abstract with AI tells** — a synthetic abstract that includes "In recent years, X has seen remarkable progress", "novel framework", "extensive experiments demonstrate", "leverage", "state-of-the-art performance". Expected: rewrite strips these while keeping passive voice, hedges, and citations intact. No first-person singular, no opinions.

2. **Methods paragraph in passive voice** — "The dataset was split 80/20. Models were trained for 100 epochs using Adam." Expected: passive voice left alone. No conversion to active.

3. **Non-scientific paragraph, no explicit trigger** — a casual opinion paragraph with no citations or section headers. Expected: rewrite still applies the scientific default (formal, no opinions) because the user didn't ask for casual mode. This confirms the default is truly the fallback.

4. **Non-scientific paragraph with explicit trigger** — same casual paragraph, but the user says "rewrite this as an opinion piece" or "make this casual". Expected: opt-in casual mode applies, opinions and mixed feelings allowed.

For each case, ask the model to name the register it used and why, so any misfires surface without a full eval harness.
