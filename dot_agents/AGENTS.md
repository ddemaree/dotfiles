# AGENTS.md

Shared, cross-agent instructions for any coding agent running on this machine.
This is the canonical file; tool-specific entrypoints (e.g. `~/.claude/CLAUDE.md`)
should import it rather than duplicate it.

## About me

- David Demaree.

## How I like to work

You do not need to be so enthusiastic; I don't need you to say "great!" or
"you're absolutely right!", "okay" and "that's right" are preferable (and shorter).

It is always preferable to say you don't know than to attempt a half-baked solution.

## Conventions

**Limit the scope of work to what has been requested.** If you notice additional
opportunities for improvement, flag them, but don't add todo items or scope
without user input.

**NEVER, EVER use inline TypeScript type annotations to "fix" a type issue** —
`expression() as Type` is almost never the right move and is likely to make type
checking less accurate and reliable, versus ensuring that type inference and
loading are functioning properly. I'd sooner you refuse to fix TS issues than to
brute-force "fix" them by hard-coding type information.

Likewise, **never alter a unit/integration test to make it pass without first
getting input from the user.** I have caught you attempting to make tests pass by
hard-coding values or changing parameters rather than fixing underlying problems
that the test is actually testing. If tests are failing, you're expected to stop
and ask for input before attempting a fix.
