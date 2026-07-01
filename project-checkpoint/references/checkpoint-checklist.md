# Checkpoint checklist

Run this every time `project-checkpoint` fires. Skip a line only with a stated reason.

## Gather

- [ ] Located the vault brain folder for this project (from CLAUDE.md pointer).
- [ ] Read the current re-entry state before writing (README + 00/03).
- [ ] Collected the real delta: for code, `git status` / `git diff --stat` / `git log`;
      for work, the user's outputs, decisions, blockers.
- [ ] Confirmed there is a material change. If not: record "no material change", stop.

## Write back

- [ ] Current status paragraph rewritten to match reality.
- [ ] Next action set to the single most important step.
- [ ] New decisions appended with date and reason; any reversal recorded.
- [ ] New gotchas and verification recipes appended.
- [ ] README re-entry block updated (Status, Next action, Active plan).
- [ ] Active implementation plan Status log updated; phase status flipped if closed.
- [ ] `updated` and `last_synced` frontmatter bumped to today on every touched note.

## Gate and guardrails

- [ ] If pushing code under the tag rule: CHANGELOG entry + tag + release prepared,
      surfaced for the user, not auto-run.
- [ ] No parallel versions: repo docs remain pointers, vault stays canonical.
- [ ] CLAUDE.md and AGENTS.md still mirror-identical on rules.
- [ ] Full diacritics; no em dash.

## Handoff

- [ ] Printed a short handoff: what changed, where logged (paths), the one next action.
