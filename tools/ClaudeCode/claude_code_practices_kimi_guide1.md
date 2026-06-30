# claude_code_practices_kimi_guide1

 I'll search for current best practices and effective strategies for using vibe coding tools like Claude Code and Anti-Gravity to help you get tasks done efficiently. 
 Based on my research, here's a comprehensive guide on how to use **vibe coding tools** like Claude Code effectively to get tasks done:

---

## The Core Philosophy: "Plan First, Code Second"

The #1 mistake people make with AI coding tools is jumping straight into coding without planning. For anything beyond trivial tasks, this leads to rework and confusion. 

### The 4-Step Workflow That Works:

1. **Ask for a plan** — Start with: *"Create a detailed implementation plan for [task]. Think hard about the approach."*
2. **Explicit pause** — Say: *"Do not write any code yet. Just give me the plan."*
3. **Review & refine** — Question assumptions, correct direction until the plan feels right
4. **Green light** — Once satisfied, tell it: *"Proceed with implementation"*

This feels slower initially but saves massive time on rework.  

---

## Essential Setup: The CLAUDE.md File

This is your project's "permanent brain" that Claude automatically reads.  

**What to include:**
- Common bash commands (`npm run test`, `npm run build`)
- Code style guidelines (*"Use ES modules, not CommonJS"*)
- Key architectural patterns (*"State management uses Zustand; see `src/stores`"*)
- Testing instructions (*"New components require React Testing Library tests"*)

**Structure:**
- **Root CLAUDE.md** (100-200 lines): Universal rules, quick commands
- **Subdirectory CLAUDE.md** files (50-100 lines): Project-specific context for `/frontend`, `/backend`, etc.

**Pro tip:** Document what Claude gets *wrong*, not just general guidelines. 

---

## Context Management (Critical for Quality)

Context degradation is the primary failure mode with AI coding tools. 

**Best practices:**
- **Clear aggressively**: Use `/clear` at ~60k tokens or 30% context window (don't wait for limits)
- **Document & Clear pattern**: Have Claude write progress to a `.md` file, clear context, then start fresh reading that file
- **Avoid `/compact`**: It's opaque and error-prone 

---

## Effective Communication Strategies

### Be Specific, Not Vague

**❌ Bad:** *"Add a user settings page"*

**✅ Good:** *"Create a user settings page at /settings with:
- Profile section (name, email, avatar upload)
- Notification preferences (checkboxes for email/push)
- Use existing UserProfile component pattern
- Follow MUI v7 layout grid system
- Add tests for form validation"* 

### Use Visual References
For UI work, paste screenshots, drag design mocks, or provide architecture diagrams. Iterate: implement → screenshot → compare → refine. Usually 2-3 iterations produces excellent results. 

### Break Down Large Problems
If Claude can't solve something in one shot, break it into smaller sub-problems. Keep decomposing until each piece is solvable. Your software engineering skills still matter—apply them to guide the AI. 

---

## Quality Control Systems

### Continuous Quality Gates (Hooks)
Set up automated checks that run when Claude finishes: 

- TypeScript/linter checks after every edit
- Build validation before commits
- Test execution on file changes
- Block commits if tests fail (forces "test-and-fix" loop)

### Code Review Process
**Never skip human review.** Use this multi-layer approach:
1. **Self-review by Claude**: Ask it to review its own code with fresh context
2. **Human review**: Manually verify behavior and test coverage
3. **Multiple Claude instances**: One writes, another reviews (fresh context = better critique) 

### Incremental Commits
Commit early and often with meaningful messages. Each commit should compile and pass tests. This creates checkpoints you can revert to if things go wrong. 

---

## Advanced Techniques

### Sub-agents for Complex Workflows
For multi-step tasks, delegate to sub-agents:
- *"You just wrote the payment processor code. Now use a sub-agent to perform a security review."*

This keeps contexts separate and focused. Use `Task(...)` to spawn agent clones rather than building complex custom sub-agents.  

### Git Worktrees for Parallel Development
Run multiple Claude instances on independent tasks:
```bash
git worktree add ../project-feature-a feature-a
cd ../project-feature-a && claude
# In new terminal:
git worktree add ../project-feature-b feature-b
cd ../project-feature-b && claude
```
This lets you work on 3-4 tasks simultaneously without conflicts. 

### Custom Slash Commands
Create reusable prompt templates in `.claude/commands/`:
- `/dev-docs` — Create strategic plan
- `/catchup` — Read all changed files
- `/code-review` — Architectural review
- `/pr` — Clean up and prepare PR

Keep these simple—if you have long complex commands, you've created an anti-pattern.  

---

## What to Avoid

| ❌ Avoid | ✅ Do Instead |
|---------|-------------|
| Auto-formatting hooks | Run Prettier manually between sessions (saves ~160k tokens)  |
| Heavy MCP usage | Keep MCP tools under 20k tokens total |
| Complex multi-agent systems | Use simple control loops—easier to debug |
| RAG for code search | Use LLM search (ripgrep, jq) instead—simpler, fewer failure modes  |
| Vague instructions | Specific, detailed prompts with file references |
| Skipping planning | Always plan before coding for non-trivial tasks |
| Letting context fill to limits | Clear at 60k tokens or 30% threshold |

---

## Quick Start for New Users

**Week 1:** Create CLAUDE.md → Practice Plan → Review → Implement → Commit workflow → Start clearing context at 60k tokens

**Week 2:** Set up TDD workflow → Create 2-3 custom slash commands → Implement basic build checker hook

**Week 3:** Implement dev docs system (plan.md, context.md, tasks.md) → Create 1-2 Skills → Add auto-activation hooks

**Week 4:** Audit context usage → Optimize CLAUDE.md → Experiment with git worktrees 

---

## Regarding Anti-Gravity

I couldn't find specific information on "Anti-Gravity" as an AI coding tool in my search. It may be a newer tool, a niche product, or possibly a different name than what's commonly used. If you can share more details about what Anti-Gravity is (e.g., the company behind it, its primary function), I can help you find or infer best practices for it. Most vibe coding tools follow similar principles to what I've outlined above for Claude Code.

The key principles remain consistent across tools: **context management, planning before execution, specific communication, and quality verification loops** are universal for effective AI-assisted coding.