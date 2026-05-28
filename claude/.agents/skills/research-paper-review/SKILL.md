---
name: research-paper-review
description: Review and analyze academic research papers. Use this skill when the user asks to review a paper, analyze a publication, summarize research, critique methodology, extract key findings, compare papers, check for numerical inconsistencies, or assess novelty and contributions of academic work. Also triggers when the user mentions reading a PDF of a paper, wants a literature review, asks about related work, or wants to improve a paper before submission. Also triggers when the user gives just a paper title and asks for a review.
---

# Research Paper Review

Assist researchers in reviewing, analyzing, and criticizing academic papers systematically and thoroughly.

## When to Use

- User asks to review, summarize, or critique a research paper
- User shares a PDF path or just a paper title
- User wants to assess methodology, contributions, or novelty
- User needs help writing a peer review
- User wants to compare multiple papers or do a literature survey
- User wants to improve a paper before submission (pre-submission review)
- User wants to check for numerical/statistical inconsistencies
- User wants venue-specific feedback (conference, journal, or preprint)

## Inputs

- Paper: a full file path to a PDF **or** just a paper title (the skill will find it automatically)
- Target Venue (optional but recommended): conference, journal, or preprint target
               - Example: "Models 2026", "TOSEM", "Sosym", "arXiv preprint"
- Type of paper (optional but recommended): "full research" paper, "short" paper, "new ideas" paper, "tool demo", "poster",...
- Explicit reviewing guidelines (optional): if available provide a description or URL with the reviewing criteria.

## Review Workflow

### Step 0: Locate the Paper

Before anything else, resolve where the paper lives.

- **If the user gave a full file path** (starts with `/` or `~`): use it directly. Skip to Step 1.
- **If the user gave only a title or partial name**: search for it recursively under `~/Zotero/storage/` using a case-insensitive filename match:
  ```bash
  find ~/Zotero/storage/ -iname "*<title>*" -type f
  ```
  - If **exactly one match** is found: use it silently and proceed.
  - If **multiple matches** are found: list them numbered and ask the user to pick one before continuing.
  - If **no match** is found: tell the user no PDF was found under `~/Zotero/storage/` matching that title, and ask them to provide the full path.

### Step 1: Pre-Processing / Venue Context

- If target venue and/or the type of paper are provided, include them as context for all subsequent steps:

> "Review this paper as if it is intended for [TARGET VENUE] as a [TYPE PAPER] submission. Consider typical standards, expectations, page limits, scope, and audience for this venue and type of paper"

- Optional: Use the provided reviewing guidelines or try to find them on the venue website (if available) with standards for methodology, novelty, empirical rigor, validation and formatting.

### Step 2: Read the Paper

Identify the format and read accordingly:

- **PDF**: Use the Read tool with the `pages` parameter for large documents (max 20 pages per request).
- **LaTeX source**: Read the main `.tex` file first. Look for `\input{}` or `\include{}` commands to find additional sections, figures, and bibliography files. Use Grep to search for key commands like `\begin{abstract}`, `\section`, `\cite` across all `.tex` files.
- **Multiple files**: Use Glob with `**/*.tex` to find all source files, then read them in logical order (main file → sections → appendix).

In all cases, skim the abstract, introduction, and conclusion first to get the big picture before diving into details.

### Step 3: Structured Summary

Show that you understand the paper by producing a summary covering:

1. **Problem Statement** — What problem does the paper address? Why does it matter?
2. **Contributions** — What are the claimed contributions? (list them)
3. **Approach/Methodology** — How do the authors solve the problem?
4. **Key Results** — What are the main findings/metrics?
5. **Limitations** — What are the acknowledged (and unacknowledged) limitations?

### Step 3b: Visual Highlights & Demo Links

Immediately after the Summary section in the output, include a **"Visual Overview"** section with two types of content:

**1. Demo / video links**
Scan the full text for any URLs pointing to video demonstrations, project pages, or supplementary material (e.g. YouTube, GitHub Pages, arXiv supplementary). Include every one you find as a markdown link with a short descriptive label.

**2. Key figures**
Identify figures that give the reader an immediate intuition for the *framework, architecture, or proposed methodology* — the kind of diagram that, if shown to a newcomer, would let them grasp what the paper is about in seconds. Good candidates:
- System/pipeline overview diagrams
- Architecture figures (e.g. neural network layout, agent loop)
- Methodology flow charts
- Qualitative results showing the system *in action* (e.g. robot performing a task, step-by-step execution)

Exclude figures whose primary purpose is to report a metric rather than explain a concept: training curves, bar charts, ablation tables, confusion matrices, result plots.

For each selected figure, extract it using this strategy — try in order, stop at the first that succeeds:

**Method 1 — `pdfimages -all` (preferred, extracts only the image without surrounding text)**
```bash
pdfimages -all -f <page> -l <page> "/path/to/paper.pdf" /tmp/fig_<N>
# produces: /tmp/fig_<N>-000.png, /tmp/fig_<N>-001.jpg, etc.
```
- If **one image** is produced: use it directly.
- If **multiple images** are produced (sub-panels, logos, decorations): pick the largest file by size — it is almost certainly the main figure. Discard obviously small ones.
- If **no images** are produced (figure is vector/text-based with no raster content): fall through to Method 2.

**Method 2 — `pdftoppm` (full-page render, always works but includes surrounding text)**
```bash
pdftoppm -f <page> -l <page> -r 200 -png "/path/to/paper.pdf" /tmp/fig_<N>
```

**Saving and embedding**
Save the result to `~/notes/Media/<paper title> - Fig <N>.png` — convert to PNG using `magick` (ImageMagick v7):
```bash
magick /tmp/fig_<N>-000.jpg "~/notes/Media/<paper title> - Fig <N>.png"
```
Then embed in the markdown with a fixed display width of 1000px (Obsidian syntax):
```
![[<paper title> - Fig <N>.png|1000]]
```

If neither method is feasible, fall back to a plain-text reference: *"Fig. N — [caption] (p. X)"*.


### Step 4: Numerical & Consistency Checks

This is where LLM-assisted review adds the most value, catching things humans easily miss during manual review. Run these checks systematically:

- **Numbers across text, tables, and figures**: Do values reported in the text match what's in the tables? Do figures reflect the data described?
- **Statistical consistency**: Do p-values, confidence intervals, and effect sizes align? Are sample sizes consistent throughout?
- **Calculations**: Verify percentages, averages, sums. Check that reported improvements (e.g., "30% improvement") match the actual numbers.
- **Internal references**: Do all \ref, \cite, figure/table references resolve? Are there dangling references or wrong numbering?
- **Acronyms**: Are all acronyms defined on first use?
- **Terminology consistency**: Is the same concept always referred to with the same term?
- **Citations**: Do all citations exist? Is citation style uniform (i.e. all conference papers are cited using the same fields, same for other venues)

Even minor errors (typos, broken references, wrong numbering) matter — reviewers often use these as signals that the paper was not carefully prepared.

### Step 5: Critical Analysis

Evaluate the paper on these dimensions:

| Dimension | Questions to Answer |
|-----------|-------------------|
| **Novelty** | Is this genuinely new? How does it differ from prior work? |
| **Soundness** | Is the methodology rigorous? Are experiments well-designed? |
| **Significance** | Does this advance the field meaningfully? |
| **Clarity** | Is the paper well-written and well-structured? |
| **Reproducibility** | Could someone replicate this work from the paper alone? |
| **Related Work** | Is the positioning against prior work fair and complete? |
| **Venue Alignment** | Does the paper meet expectations of the target venue (scope, depth, format, length, contribution type)? |


### Step 6: Provide Actionable Feedback

Structure feedback as:

- **Strengths** — What the paper does well (be specific, cite sections)
- **Weaknesses** — What could be improved (be constructive, suggest fixes)
- **Questions for Authors** — Things that need clarification
- **Minor Issues** — Typos, formatting, citation issues, broken references
- **Venue-Specific Recommendations** — Highlight alignment issues, potential improvements to meet venue expectations

### Step 7: Top Actions — Start Here

Write down a list of the top 10 most immediate actions that the author should address.

These should be the ones that will bring the best "bang for the buck", i.e. actions that generate the most benefit relative to the cost of implementing them.


## Output Format

The review must be saved as an **Obsidian-compatible markdown file**. This means:

- Use standard markdown syntax throughout (headings, bold, italics, bullet lists, tables, horizontal rules)
- Begin the file with a **YAML frontmatter block** containing key metadata that Obsidian can index and display
- Use `#` headings rather than HTML or other markup
- Keep tables in standard markdown pipe format
- Avoid raw HTML tags — they won't render cleanly in Obsidian's reading view

Use this exact template (fill in all fields):

```markdown
---
title: "<full paper title>"
authors: "<Author1, Author2, ...>"
year: <publication year>
venue: "<journal or conference name>"
doi: "<DOI if available, else omit>"
tags:
  - paper-review
  - <field tag, e.g. reinforcement-learning>
  - <another relevant tag>
date_reviewed: <today's date, YYYY-MM-DD>
overall: "<accept | major-revision | minor-revision | reject>"
---

# Paper Review: [Title]

## Summary
[2-3 paragraph summary]

## Visual Overview

### Demo Videos
- [Demo title](URL)

### Key Figures
![[<paper title> - Fig N.png|1000]]
*Fig. N — [caption describing what it shows]*

## Strengths
- S1: ...
- S2: ...

## Weaknesses
- W1: ...
- W2: ...

## Questions for Authors
- Q1: ...

## Minor Issues
- ...

## Venue-Specific Recommendations
- V1: ...
- V2: ...

## Overall Assessment
[1 paragraph verdict: accept/revise/reject with justification]

## Top Actions — Start Here
- T1: ...
- T2: ...

## Confidence
[Your confidence level in this review: low/medium/high, and why]
```

## Step 8: Save the Review

After the review is written, save it to disk.

**Determine the output filename**: use only the paper title (no path prefix, no author names). Spaces in the filename are fine. For example, for a paper titled *"Attention Is All You Need"*, the output path is:
```
~/notes/Literature/Papers Briefly Analyzed/Attention Is All You Need.md
```

**Check for an existing file first**:
```bash
ls ~/notes/Literature/Papers\ Briefly\ Analyzed/<paper title>.md
```
- If the file **does not exist**: write it directly.
- If the file **already exists**: ask the user:
  > "A review for **[paper title]** already exists. Would you like to **(1) Overwrite** the existing file or **(2) Append** the new review to it?"
  - **(1) Overwrite**: replace the file content entirely with the new review.
  - **(2) Append**: add a horizontal rule (`---`) followed by the new review at the end of the existing file. Note: appending will result in two YAML frontmatter blocks — warn the user that Obsidian only reads the first one, and suggest they merge them manually if needed.

Confirm to the user once saved, including the full path of the file written.
