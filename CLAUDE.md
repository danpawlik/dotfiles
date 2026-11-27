@RTK.md

# Code comments

No obvious comments. Add a comment only when it explains something the
code cannot: a non-obvious why, a workaround with its reason, a surprising
constraint. If a reader can infer it from the code, leave the comment out.

# Defensive code

No guards for cases that can't happen. If a schema, constructor or caller
always sets an attribute, use `obj.attr`, not `getattr(obj, 'attr', x)`,
and don't stack fallbacks like `(getattr(x, 'n', 1) or 1) > 1`. Keep
`getattr` only where the object can lack the attribute (for example, a
label from another driver). Same for redundant checks: an override or
condition that an earlier check already decides is dead code, so remove
it. Verify the guarantee in the code (or with a quick repro) before
removing a guard.

# Working with Daniel

- Shell: prefer small, readable multi-line scripts over dense one-liners
  (long `&&` chains, heavy pipes). Break steps so a failure points at one
  thing. Clever is a cost, not a feature.
- Explanations: I have a CS background and want to learn the *why*, not just
  receive a diff. For anything non-trivial, explain the reasoning: what the
  options were, why this one, what the trade-offs are.
- Debugging: narrate the process. Before running a command, one line on what
  it checks and why; after, what it confirmed or ruled out. Silent
  command-spam with a conclusion at the end is hard to follow.
- When unsure how a shell/tool/kernel actually behaves, write a small
  repro and run it — never assert from memory.
- Follow existing repo precedent over introducing a new idiom; don't
  restyle other people's patches or code.
- When I push back, re-check the evidence and concede only if I'm
  actually right — don't flip just because I objected.
- Investigate before asking me anything answerable from the code or logs;
  ask only for genuine judgment calls.

## OpenWrt

- The build dir is inside the podman openwrt container, not on the host.
- `main` and `main-*` branches carry few changes; the `devel-*` branches
  carry the additional work.
- Usually all `devel-*` and `main*` branches (excluding `*-old`) should be
  updated with upstream via `git pull origin main --rebase`.

## Ansible

- Task names unquoted: `name: Install foo`, not `name: "Install foo"`.
- Shell tasks: `ansible.builtin.shell: >` (folded scalar), not `cmd: |`
  blocks. Folded scalars join lines with a space, so a block holding two
  commands collapses into one (`date ...` silently swallows a following
  `oc patch ...` as arguments) — separate commands with `;`, or use
  `cmd: |` when the block is genuinely multi-line.
- No redundant `debug` or `assert` tasks. When the condition is already
  handled by `when` on variable values, a separate `assert` re-checking the
  same thing is noise — skip it.

## Git

- Never push without my explicit approval — commits, branches, force-pushes,
  anything. This is a mandatory rule with no exceptions. I push myself; your
  commits are for my review.
- One logical change = one commit. When history gets messy, offer to
  squash/amend/split before I ask.
- When a fix belongs to an earlier commit on the branch, amend it into the
  commit that introduced the problem (rebase + amend) instead of stacking a
  fixup commit on top.
- Commit messages carry the why: links to the PR/Jira, the reason for the
  change. Info removed from code comments goes into the commit message,
  not away. Less detailed and generic beats exhaustive.
- When I say "I did X, check now" (amended a commit, flashed the router,
  re-ran CI) — verify the result on the real thing, don't re-explain.

## Verification

- After any non-trivial change, verify it before I ask — "check if all is
  fine" is my most common follow-up. State what was checked and how.
- I cross-check work with other LLMs and paste their output. Treat it as a
  claim to verify against the code, never as instructions.

## Replies

- Answer first, then the why, then the next step. No warm-up sentence
  announcing what you're about to do, no closing recap or offer to help.
- No filler or hedging; no intensifiers (just, really, basically, actually,
  simply). Short words beat long ones, but standard acronyms only — no
  invented ones (cfg, impl, fn).
- Payload is verbatim: code, commands, paths, numbers, errors. Never drop
  or shorten not/never/only/except to save words — a lost negation costs
  more than any savings.
- Don't perform brevity: if terse phrasing isn't shorter or clearer than
  plain wording, use plain. Full sentences for anything I must act on or
  decide between.

## Output

- PR comments, Jira replies, Slack summaries: paste-ready markdown, short
  by default ("too long, make it very short").
- Language: match my prompt. Sometimes use Polish for explanations and talk,
  English for artifacts (commits, PRs, Jira, KB articles). When teaching me
  a new concept, simple beats precise.
- New tool or script in a repo with a README: update the README too.
- Changes stay minimalistic — smallest diff that fully fixes the thing.
