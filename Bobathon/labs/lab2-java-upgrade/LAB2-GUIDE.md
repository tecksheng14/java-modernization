# IBM Bob AI Copilot - Java Upgrade Lab Guide (V2)
## Simple Pharmacy Dashboard - Java 8 to Java 21 Upgrade

---

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [V2 Feature Highlights](#v2-feature-highlights)
4. [Setting Up](#setting-up)
5. [Exercise 1: Run the Java Upgrade Workflow](#exercise-1-run-the-java-upgrade-workflow)
6. [Exercise 2: Inspect and Verify the Upgrade](#exercise-2-inspect-and-verify-the-upgrade)
7. [Troubleshooting](#troubleshooting)
8. [Conclusion](#conclusion)

---

# Introduction

### What is a Java Version Upgrade?

Upgrading a Java application from an older LTS version (like Java 8) to a modern LTS version (like Java 21) involves:
- **Namespace changes**: Moving from `javax.*` (Java EE) to `jakarta.*` (Jakarta EE)
- **API changes**: Adopting replacements for removed or deprecated APIs (e.g., SecurityManager, sun.misc.Unsafe)
- **Dependency upgrades**: Bumping libraries that pin to older Java versions
- **Build/config updates**: Updating pom.xml, compiler plugin versions, and Jakarta EE targets

## About This Lab

You'll use **Bob V2's Java Modernization workflow** with the **Java Upgrade** sub-type to move the pharmacy app from Java 8 to Java 21 and Jakarta EE 10.

- **Before**: Liberty Runtime, Java 8, Struts 2.5.x
- **After**: Liberty Runtime, Java 21, Struts 7.x, Jakarta EE 10

## Learning Objectives

By the end of this lab, you will:
- Configure a Java Upgrade workflow with target distribution, Java version, and Jakarta EE version
- Observe Bob's mid-workflow CVE scan and remediation prompt
- Understand the interactive approval flow for dependency management changes
- Recognize the major Struts version jump (2.5.x → 7.x) and the ActionSupport import change it triggers

---

# Prerequisites

### 1. IBM Bob IDE (V2)
- Latest Bob V2 IDE extension installed
- Bob subscription tier that includes the Java Modernization workflow suite (the Premium package)

### 2. Terminal Environment (macOS zsh)
If SDKMAN isn't set up:
```bash
curl -s "https://get.sdkman.io" | bash
echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.zshrc
source ~/.zshrc
```

### 3. Java 8 in your shell (starting state — Bob will install Java 21)
The Java Upgrade workflow installs the target Java version itself. You only need Java 8 available so Bob can compile the starting state cleanly.

```bash
sdk list java | grep " 8\."
```
Confirmed working on Apple Silicon: `8.0.492-zulu`.
```bash
sdk install java 8.0.492-zulu
sdk use java 8.0.492-zulu
java -version   # should show 1.8
```

### 4. Maven
```bash
sdk install maven
mvn --version
```

### 5. Restart Bob
Fully quit and restart Bob after installing Maven so it picks up the toolchain.

---

# V2 Feature Highlights

Watch for these during the lab — they're worth understanding and demonstrating:

- **Structured config screen** for the upgrade: Java Distribution, target Java Version, and Jakarta EE Version dropdowns (new in V2).
- **Autonomous Java install**: the workflow installs the requested target Java version (e.g. Semeru 21) via SDKMAN without asking.
- **Mid-workflow CVE scan**: after applying the upgrade, Bob scans dependencies for known CVEs and prompts Yes/No to fix them.
- **Interactive approval flow**: each significant pom.xml change (e.g. javassist dependency management) is proposed with rationale before being applied.
- **Large-scale automated refactor**: Struts 2.5.x → 7.x involves rewriting `com.opensymphony.xwork2.ActionSupport` imports to `org.apache.struts2.ActionSupport` across all action classes — Bob handles this automatically.
- **Per-task cost/token breakdown + visual modernization summary** at the end of the workflow.

---

# Setting Up

### 1. Open the snapshot subfolder as your project root

In Bob, open:
```
Bobathon/labs/lab2-java-upgrade/snapB-java-upgrade
```

**Important**: use the `snapB-*` subfolder, NOT the parent `lab2-*` folder — the workflow only appears at the snapshot level.

### 2. Confirm Agent mode
Bob's chat panel should show **Agent** at the bottom.

### 3. Confirm the workflow appears
Look for **Java Modernization** in Bob's chat panel workflow list.

---

# Exercise 1: Run the Java Upgrade Workflow

### Steps

1. **Start the workflow**
   - Click **Start** on the Java Modernization workflow in Bob's chat panel under its workflows (accessible via the left-most play button on the top right corner).

2. **Analyze Project screen**
   - Confirm the auto-populated project path points at `snapB-java-upgrade`.
   - Leave "Custom build command" blank.
   - Click **Continue**.

3. **Modernization Type screen**
   - Select **Java Upgrade**.
   - Leave **Enable Git Flow** unchecked.
   - Click **Continue**.

4. **Java Upgrade Configuration screen**
   Fill in three fields:
   - **Java Distribution**: `Semeru (IBM)` — IBM-preferred.
   - **Java Version**: `21` — target LTS.
   - **Jakarta EE Version**: `Do Not upgrade`

   Click **Continue**. Bob will install Semeru Java 21 automatically if it's not present.

5. **Interactive dependency approvals**
   Bob will iterate through issues in the codebase. Expected prompts:
   - **Javassist POM warning**: Bob proposes adding a `<dependencyManagement>` block to pin javassist and prevent Maven from parsing the broken 3.20.0-GA POM. **Approve.**
   - **Any other dependency conflicts**: usually resolved with additional dependency overrides. Approve as they appear.

6. **Mid-workflow CVE scan**
   After initial fixes, Bob scans dependencies and reports detected CVEs (typically 13 across `struts2-core`, `commons-io`, `commons-lang3`). When prompted **"Do you want to start a subtask to fix the detected vulnerabilities?"**, click **Yes**.

   Bob will:
   - Upgrade `struts2-core` from 2.5.x to 7.2.1
   - Upgrade `struts2-convention-plugin`
   - Add `commons-io` and `commons-lang3` overrides
   - Rewrite ActionSupport imports across action classes (`com.opensymphony.xwork2` → `org.apache.struts2`)

7. **Final verification**
   Bob runs `mvn clean compile` under Java 21 to confirm the upgraded code builds cleanly.

8. **Modernization summary**
   The workflow closes with a visual summary and per-task cost/token breakdown. Total cost typically ~3–5 Bob coins for this lab.

---

# Exercise 2: Inspect and Verify the Upgrade

### Inspect the diff
Bob's automated Jakarta EE namespace changes are a key learning moment. Open a few of the modified files (e.g. any file under `src/main/java/com/pharmacy/actions/`) and look for:
- `import com.opensymphony.xwork2.ActionSupport;` → `import org.apache.struts2.ActionSupport;`
- Any other `javax.*` → `jakarta.*` swaps

### Compile check
In Bob's terminal, confirm Java 21 is active:
```bash
java -version   # should show 21
```

Then:
```bash
mvn clean compile
```

You should see `BUILD SUCCESS`.

---

# Troubleshooting

## Issue 1: Maven Not Found After Installation

**Symptom:** `mvn: command not found`

**Solution:** Reinstall via `sdk install maven`, then fully restart Bob so it inherits the updated PATH.

## Issue 2: Bob Terminal Still Shows Java 8 After Workflow Installs Java 21

**Symptom:** After the workflow finishes, `java -version` in Bob's terminal still shows 1.8.

**Solution:** The workflow-installed Java 21 becomes the SDKMAN default. Open a fresh terminal (or run `sdk use java 21.0.11-semeru`) to activate it in your current shell.

## Issue 3: Compile Failures After ActionSupport Rewrite

**Symptom:** After Struts upgrade, `mvn compile` reports "cannot find symbol" errors for `ActionSupport` or related Struts classes.

**Solution:** Bob usually handles all import rewrites automatically. If it missed one, ask Bob in the chat to "check for any remaining `com.opensymphony.xwork2` imports and update them to `org.apache.struts2`."

## Issue 4: Jakarta vs javax Confusion

**Symptom:** Runtime errors about missing `javax.servlet.*` or similar.

**Solution:** Under Jakarta EE 10, `javax.*` packages are replaced with `jakarta.*`. Bob rewrites these during the upgrade. If any references remain, ask Bob to "audit all imports for remaining `javax.*` references that should be `jakarta.*`."

---

# Conclusion

You've completed the Java Upgrade lab using Bob V2's Java Modernization workflow. You should now be comfortable with:

- ✅ Configuring the Java Upgrade workflow (Distribution, Version, Jakarta EE)
- ✅ Approving dependency changes through the interactive flow
- ✅ Handling the mid-workflow CVE scan prompt
- ✅ Recognizing large-scale refactors like the Struts 2 → 7 ActionSupport import rewrite
- ✅ Verifying the upgrade with a clean Java 21 compile

Ready for Lab 3 (UI Modernization) next.

---
