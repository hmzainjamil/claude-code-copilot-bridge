# Decision Trees

**Reading time**: 5 minutes | **Skill level**: All levels | **Last updated**: 2026-01-22

Visual decision guides to help you choose the right command, provider, and model for your specific situation.

---

## 📋 Table of Contents

- [Which Command Should I Use?](#which-command-should-i-use)
- [Which Provider for My Project?](#which-provider-for-my-project)
- [Which Model for This Task?](#which-model-for-this-task)
- [Troubleshooting Decision Tree](#troubleshooting-decision-tree)
- [Performance Optimization Path](#performance-optimization-path)

---

## Which Command Should I Use?

**Start here if you're not sure which command to run:**

```
                    🎯 START HERE
                         │
                         ▼
            ┌────────────────────────┐
            │ Do you need to work    │
            │ offline or keep code   │
            │ 100% private?          │
            └────────┬───────────────┘
                     │
          ┌──────────┴──────────┐
          │                     │
         YES                   NO
          │                     │
          ▼                     ▼
      Use cco          ┌─────────────────┐
   (Ollama Local)      │ Do you have     │
   100% Private        │ GitHub Copilot  │
   Offline capable     │ Pro+?           │
                       └────┬────────────┘
                            │
                 ┌──────────┴──────────┐
                 │                     │
                YES                   NO
                 │                     │
                 ▼                     ▼
        ┌────────────────┐      Use ccd
        │ What's your    │   (Anthropic Direct)
        │ task type?     │   Pay-per-token
        └───┬────────────┘   Best quality
            │
     ┌──────┼──────┬──────────┐
     │      │      │          │
     ▼      ▼      ▼          ▼
  Quick  Daily  Code      Compare
  Q&A    Dev   Review   Approaches
     │      │      │          │
     ▼      ▼      ▼          ▼
 ccc-   ccc-   ccc-      ccc-gpt
 haiku  sonnet opus    (GPT-4.1)
 (Fast) (Bal.) (Best)  (Alt view)
```

**Quick Reference**:
- **Offline/Private** → `cco`
- **Daily dev** → `ccc` or `ccc-sonnet`
- **Quick questions** → `ccc-haiku`
- **Code reviews** → `ccc-opus`
- **No Copilot** → `ccd`

---

## Which Provider for My Project?

**Choose provider based on project characteristics:**

```
         🎯 PROJECT CHARACTERISTICS
                    │
                    ▼
        ┌───────────────────────┐
        │ Is this proprietary   │
        │ or confidential code? │
        └───────┬───────────────┘
                │
         ┌──────┴──────┐
         │             │
        YES           NO
         │             │
         ▼             ▼
     Use cco    ┌──────────────────┐
   (Ollama)     │ How many files   │
   100%         │ in the project?  │
   Private      └──────┬───────────┘
                       │
            ┌──────────┼──────────┐
            │          │          │
            ▼          ▼          ▼
        < 500     500-2K      > 2K
        files     files      files
            │          │          │
            ▼          ▼          ▼
        cco or    ccc or      ccc or
         ccc       ccd         ccd
      (Either)   (Cloud)    (Cloud)
                 faster      faster
```

**By Project Size**:
- **Small** (<500 files) → Any provider works well
- **Medium** (500-2K files) → Prefer `ccc` or `ccd` (cloud)
- **Large** (>2K files) → Use `ccc` or `ccd` only (Ollama too slow)

**By Sensitivity**:
- **Confidential** → `cco` only
- **Internal** → Any provider OK
- **Open source** → Any provider OK

---

## Which Model for This Task?

**Choose model based on task requirements:**

```
              🎯 WHAT ARE YOU DOING?
                        │
         ┌──────────────┼──────────────┐
         │              │              │
         ▼              ▼              ▼
    Exploring     Implementing    Reviewing
     codebase        feature         code
         │              │              │
         ▼              ▼              ▼
    ┌─────────┐   ┌─────────┐   ┌─────────┐
    │ Quick   │   │ Quality │   │ Need    │
    │ scan?   │   │ matters?│   │ best?   │
    └────┬────┘   └────┬────┘   └────┬────┘
         │             │             │
      ┌──┴──┐       ┌──┴──┐       ┌──┴──┐
      │     │       │     │       │     │
     YES   NO      YES   NO      YES   NO
      │     │       │     │       │     │
      ▼     ▼       ▼     ▼       ▼     ▼
   haiku sonnet  opus sonnet   opus  sonnet
   (Fast) (Bal.) (Best) (Bal.) (Best) (Good)
```

**Task-Based Selection**:

| Task Type | Model | Reasoning |
|-----------|-------|-----------|
| **Quick questions** | `ccc-haiku` | Fast, good enough for simple queries |
| **Code exploration** | `ccc-haiku` | Speed matters for rapid iteration |
| **Daily development** | `ccc-sonnet` | Best balance of quality/speed |
| **Feature implementation** | `ccc-sonnet` | Reliable, efficient |
| **Bug fixing** | `ccc-sonnet` | Good analysis capabilities |
| **Code reviews** | `ccc-opus` | Thoroughness critical |
| **Security audits** | `ccc-opus` | Need best detection |
| **Architecture design** | `ccc-opus` | Deep reasoning required |
| **Refactoring** | `ccc-sonnet` | Balanced approach |
| **Documentation** | `ccc-haiku` | Simple, repetitive task |
| **Learning/experimenting** | `ccc-haiku` | Fast feedback loop |
| **Comparing approaches** | `ccc-gpt` | Different perspective |

---

## Troubleshooting Decision Tree

**When something doesn't work:**

```
         🆘 SOMETHING NOT WORKING?
                    │
                    ▼
        ┌───────────────────────┐
        │ Run ccs to check      │
        │ provider status       │
        └───────┬───────────────┘
                │
                ▼
        ┌───────────────────────┐
        │ Which provider fails? │
        └───┬───────────────────┘
            │
     ┌──────┼──────┬──────────┐
     │      │      │          │
     ▼      ▼      ▼          ▼
  Copilot Ollama Direct   All fail
     │      │      │          │
     ▼      ▼      ▼          ▼
┌─────────┐ ┌──────────┐ ┌─────────┐ ┌─────────┐
│copilot- │ │Is Ollama │ │Is API   │ │Check    │
│api not  │ │running?  │ │key set? │ │internet │
│running? │ └────┬─────┘ └────┬────┘ │& Claude │
└────┬────┘      │            │      │Code     │
     │      ┌────┴────┐  ┌────┴────┐ │install  │
     │      │         │  │         │ └─────────┘
     ▼      ▼         ▼  ▼         ▼
   Start  Check    Pull Fix      Verify
copilot- service model key/    base
  api    restart        restart install
     │      │         │  │         │
     ▼      ▼         ▼  ▼         ▼
   Test   Test     Test Test     Test
   ccc    cco      cco  ccd      all
```

**Common Fixes**:

| Error | Quick Fix |
|-------|-----------|
| copilot-api not running | `copilot-api start` |
| Ollama not responding | `brew services restart ollama` |
| Model not found | `ollama pull devstral-small-2` |
| API key invalid | Check `echo $ANTHROPIC_API_KEY` |
| Aliases not working | `source ~/.zshrc` |

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions.

---

## Performance Optimization Path

**When Ollama is slow:**

```
        🐌 OLLAMA RUNNING SLOW?
                 │
                 ▼
     ┌───────────────────────┐
     │ How big is the        │
     │ project/context?      │
     └───────┬───────────────┘
             │
      ┌──────┴──────┬──────────┐
      │             │          │
      ▼             ▼          ▼
   Small       Medium      Large
  <10K ctx    10-40K     >40K ctx
      │             │          │
      ▼             ▼          ▼
  ┌─────────┐ ┌─────────┐ ┌─────────┐
  │Check    │ │Increase │ │Switch   │
  │model    │ │context  │ │to cloud │
  │loaded?  │ │to 16K   │ │provider │
  └────┬────┘ └────┬────┘ └────┬────┘
       │           │           │
       ▼           ▼           ▼
   Verify      Expect     Use ccc
    ollama     slower      or ccd
     ps      responses   (much
       │     15-25 tok/s  faster)
       ▼           │           │
   If slow        ▼           ▼
   increase   Still      1-3s
   to 16K      slow?    response
       │           │
       ▼           ▼
   Still    Consider
   slow?       ccc
       │           │
       ▼           ▼
   Use ccc    DONE
```

**Performance Ladder**:
1. **Ollama 8K** - 26-39 tok/s (fast, small projects only)
2. **Ollama 16K** - 15-25 tok/s (medium projects, slower)
3. **Ollama 32K** - 8-15 tok/s (large projects, slow)
4. **Copilot/Anthropic** - 1-3s total (cloud, always fast)

**When to give up on Ollama**:
- Project >2K files → Use `ccc` or `ccd`
- Response time >30s → Use `ccc` or `ccd`
- You value speed → Use `ccc` or `ccd`

---

## Provider Selection Matrix

**Quick decision matrix:**

```
┌─────────────────┬─────────────┬─────────────┬─────────────┐
│ Requirement     │ Anthropic   │ Copilot     │ Ollama      │
│                 │ (ccd)       │ (ccc)       │ (cco)       │
├─────────────────┼─────────────┼─────────────┼─────────────┤
│ Best quality    │     ✅      │     ⚠️      │     ❌      │
├─────────────────┼─────────────┼─────────────┼─────────────┤
│ Lowest cost     │     ❌      │     ✅      │     ✅      │
├─────────────────┼─────────────┼─────────────┼─────────────┤
│ 100% private    │     ❌      │     ❌      │     ✅      │
├─────────────────┼─────────────┼─────────────┼─────────────┤
│ Offline capable │     ❌      │     ❌      │     ✅      │
├─────────────────┼─────────────┼─────────────┼─────────────┤
│ Fast (1-3s)     │     ✅      │     ✅      │ ❌ (varies) │
├─────────────────┼─────────────┼─────────────┼─────────────┤
│ Large projects  │     ✅      │     ✅      │     ⚠️      │
├─────────────────┼─────────────┼─────────────┼─────────────┤
│ MCP compatible  │     ✅      │     ✅      │     ✅      │
└─────────────────┴─────────────┴─────────────┴─────────────┘

✅ Excellent  ⚠️ Limited/Conditional  ❌ Not supported
```

---

## Quick Decision Shortcuts

**Memorize these for instant decisions:**

1. **Need it fast?** → `ccc` or `ccd` (cloud)
2. **Need it free?** → `ccc` or `cco` (Copilot or Ollama)
3. **Need it private?** → `cco` (Ollama only)
4. **Need best quality?** → `ccd` or `ccc-opus`
5. **Learning/experimenting?** → `ccc-haiku` (fast iteration)
6. **Large codebase?** → `ccc` or `ccd` (cloud only)
7. **Quick question?** → `ccc-haiku` (fastest)
8. **Code review?** → `ccc-opus` (most thorough)
9. **Don't know?** → `ccc-sonnet` (safe default)
10. **Having issues?** → `ccs` (check status first)

---

## 📚 Next Steps

Based on your decision:

**Chose ccc (Copilot)**:
- Learn model switching: [MODEL-SWITCHING.md](MODEL-SWITCHING.md)
- Optimize usage: [BEST-PRACTICES.md](BEST-PRACTICES.md)

**Chose cco (Ollama)**:
- Optimize performance: [OPTIMISATION-M4-PRO.md](OPTIMISATION-M4-PRO.md)
- Troubleshoot slowness: [TROUBLESHOOTING.md#ollama-slow](TROUBLESHOOTING.md)

**Chose ccd (Anthropic)**:
- Understand costs: [FAQ.md#cost--billing](FAQ.md#cost--billing)
- Production tips: [BEST-PRACTICES.md](BEST-PRACTICES.md)

---

**Related Documentation**:
- [Quick Start Guide](../QUICKSTART.md)
- [Command Reference](COMMANDS.md)
- [FAQ](FAQ.md)
- [Best Practices](BEST-PRACTICES.md)

**Back to**: [Documentation Index](README.md) | [Main README](../README.md)
