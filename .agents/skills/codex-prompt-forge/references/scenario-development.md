# Scenario: Development (new code and features)

Risk profile: overengineering, invented APIs, code hardcoded to pass tests,
divergence from repository patterns. Rigidity: medium — constrain scope and
verification, keep the solution space open.

## Required slots

| Slot | Ask (in the user's language) | Default when the user cannot answer |
|---|---|---|
| Task definition | What exactly should be built? What behavior counts as done? | none — must be user-stated |
| Stack and language | Which language/framework? | delegation: session detects it from the repository and confirms before coding |
| Pattern reference | Which existing file shows the pattern to imitate? | delegation: session finds the closest existing pattern and follows it |
| Dependency policy | Are new libraries allowed? | only libraries already present in the project |
| Edge cases | Which edge cases matter? | delegation: session enumerates the edge cases it will handle in its plan, for review before implementation |
| Acceptance criteria | Which observable results mean done? Test command? | delegation: session proposes acceptance tests in its plan for approval before implementing |
| Output form | Which files/paths should result? | delegation: session proposes the file layout in its plan |

## Prompt skeleton

```
<role>Senior software engineer specialized in {STACK}.</role>

<context>
Project: {SHORT DESCRIPTION}
Read and follow applicable repository instructions, including AGENTS.md.
Follow the pattern of: `{PATTERN FILE}`
Dependency policy: {POLICY}
</context>

<task>
Implement {FEATURE}.
1. Inspect the minimum relevant files and, when the work is multi-file or
   uncertain, propose a short plan before coding.
2. {FURTHER STEPS}
</task>

<constraints>
- Minimal scope: do not add features, abstractions, or files beyond the
  request.
- Do not hardcode for the test cases; tests verify correctness, they do not
  define the solution.
- Handle these edge cases explicitly: {EDGE CASES}.
</constraints>

<output_format>{FILES/PATHS AND WHAT EACH CONTAINS}</output_format>

<acceptance_criteria>
Done when: {OBSERVABLE CRITERIA}.
Run {TEST COMMAND} after implementing, report the result, and iterate within
the authorized scope until it passes. If the command is unknown, discover the
relevant repository check and report it before changing tests.
</acceptance_criteria>
```

## Standard clauses (provenance: template)

- Minimal-scope constraint — counters overengineering.
- Anti-hardcoding clause — tests verify the solution, they do not define it.
- Explore-and-plan-first opening — agentic best practice for multi-file work.

## Assembly notes

- If the feature is rich but expectations are vague, push during the
  interview for observable acceptance criteria; "make it good" produces
  generic output.
- Keep the plan step when the work spans multiple files or unfamiliar code;
  drop it when the user describes a change they could state as a one-file
  diff, where planning is overhead.
