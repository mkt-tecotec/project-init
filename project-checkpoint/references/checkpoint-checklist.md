# Checkpoint checklist

Run this every time `project-checkpoint` fires. Skip a line only with a stated reason.

## Gather

- [ ] Read the "Brain backend" block in CLAUDE.md: which backend is canonical, and
      where the project root document or folder is.
- [ ] Confirmed that backend actually responds. If not: fall back to
      `docs/AGENT_BOOTSTRAP.md`, tell the user, and flag the sync debt.
- [ ] Read the current re-entry state before writing (re-entry page + 00/03).
- [ ] Collected the real delta: for code, `git status` / `git diff --stat` / `git log`;
      for work, the user's outputs, decisions, blockers.
- [ ] Confirmed there is a material change. If not: record "no material change", stop.

## Write back

- [ ] Current status paragraph rewritten to match reality.
- [ ] Next action set to the single most important step.
- [ ] New decisions appended with date and reason; any reversal added as a new dated
      entry naming what it supersedes. No prior decision edited or deleted.
- [ ] New gotchas and verification recipes appended.
- [ ] Re-entry page updated (Status, Next action, Active plan).
- [ ] Active implementation plan Status log updated; phase status flipped if closed.
- [ ] Date stamped: Outline status block updated, or `updated` and `last_synced`
      frontmatter bumped on every touched vault note.
- [ ] If a secondary drafting layer was used this session, it has been synced one way
      into the canonical brain.

## Permission gate

- [ ] Nothing about budget, leadership proposals, HR, or candid commentary about people
      was appended into a team-wide collection. Those went to the restricted one.
- [ ] No public share link was enabled outside the designated external-sharing
      collection.
- [ ] No operational state (task lists, percentages, deadlines) copied out of the ops
      system into the brain; links used instead.

## Release gate and guardrails

- [ ] If pushing code under the tag rule: CHANGELOG entry + tag + release prepared,
      surfaced for the user, not auto-run.
- [ ] No parallel versions: repo docs remain pointers, the canonical brain holds
      content.
- [ ] CLAUDE.md and AGENTS.md still mirror-identical on rules.
- [ ] Outline documents have no YAML frontmatter and no leading H1.
- [ ] Full diacritics; no em dash.

## Handoff

- [ ] Printed a short handoff: what changed, where logged (URLs or paths), the one next
      action.
