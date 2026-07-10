# IBM Bob AI Copilot - Java Liberty Replatforming Lab Guide (V2)
## Simple Pharmacy Dashboard - WebSphere to Liberty Migration

---

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [V2 Feature Highlights](#v2-feature-highlights)
4. [Setting Up](#setting-up)
5. [Exercise 1: Run the Liberty Replatforming Workflow](#exercise-1-run-the-liberty-replatforming-workflow)
6. [Exercise 2: Verify the Migrated Application](#exercise-2-verify-the-migrated-application)
7. [Troubleshooting](#troubleshooting)
8. [Conclusion](#conclusion)

---

# Introduction

### What is This Application?

The **Simple Pharmacy Management System** is a web-based application that manages pharmacy operations including:
- **Prescriptions**: Create and validate patient prescriptions
- **Orders**: Process medication orders and payments
- **Medicines**: Manage medicine inventory
- **Dashboard**: Monitor pending prescriptions and orders

### What is Java Modernization?

Java Modernization is the process of upgrading legacy Java applications to modern versions and platforms. This typically involves:
- **Application Server Migration**: Transitioning from traditional servers (like WebSphere) to lightweight runtimes (like Liberty)
- **Dependency Updates**: Modernizing libraries and frameworks to current, supported versions
- **Code Transformation**: Updating code patterns to leverage modern Java features

## About This Lab

In this lab, you'll use **Bob V2's Java Modernization workflow** to modernize a legacy pharmacy application. You'll run the **Liberty Replatforming** sub-type of the workflow to migrate the app from Traditional WebSphere to Liberty.

- **Before**: Traditional WebSphere (TWas), Java 8, Struts
- **After**: Liberty Runtime, Java 8, Struts (Java version upgrade is covered separately in Lab 2)

## Learning Objectives

By the end of this lab, you will:
- Launch and complete a Bob V2 Java Modernization workflow end-to-end
- Understand the interactive approval flow Bob uses for each migration change
- Recognize and interpret Bob's per-task cost and modernization summary output
- Deploy and verify a modernized Liberty application

---

# Prerequisites

### 1. IBM Bob IDE (V2)
- Ensure the latest Bob V2 IDE extension is installed
- You need a Bob subscription tier that includes the Java Modernization workflow suite (the Premium package)

### 2. Terminal Environment (macOS)
The Liberty Replatforming workflow can install its own tools, but a working shell setup helps. On macOS the default shell is **zsh**.

If SDKMAN is not installed:
```bash
curl -s "https://get.sdkman.io" | bash
echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.zshrc
source ~/.zshrc
```

Verify: `sdk version`

### 3. Java 8 (optional — the workflow can install it for you)
If you want a pre-set environment, install a Java 8 build. Note that stale identifiers like `8.0.432-tem` no longer exist on SDKMAN, and Temurin 8 isn't available on Apple Silicon.

To pick a working build:
```bash
sdk list java | grep " 8\."
```
Confirmed working on Apple Silicon: `8.0.492-zulu`.
```bash
sdk install java 8.0.492-zulu
sdk default java 8.0.492-zulu
java -version
```

### 4. Maven (via SDKMAN)
```bash
sdk install maven
mvn --version
```

### 5. Restart Bob
After installing Maven, fully quit and restart Bob so it picks up the new tools.

---

# V2 Feature Highlights

Bob V2's Java Modernization workflow introduces several capabilities worth watching for during this lab:

- **Interactive approval flow**: Bob proposes each migration change and asks for explicit approval before applying it. You can accept, revise, or ask for a preview of the exact edit.
- **Iterative issue-by-issue upgrade**: Rather than running all recipes at once, the workflow addresses each migration issue individually with rationale for the fix.
- **Layered mitigations**: When appropriate, Bob suggests both a library-level fix and a runtime-level fix (e.g. upgrading OGNL AND adding a JVM option) for defense in depth.
- **Per-task cost/token breakdown**: The workflow summary at the end shows exact cost in Bob coins and token counts per subtask.
- **Visual modernization summary**: An auto-generated graphic at the end shows every step performed, categorized by outcome.
- **Autonomous tool install**: If Java isn't set up, the workflow will install the required version via SDKMAN itself.

---

# Setting Up

### 1. Open the snapshot subfolder as your project root

In Bob, open **this exact folder** as the project root:
```
Bobathon/labs/lab1-java-liberty-replatforming/snapA-java-liberty-replatforming
```

**Important**: The Java Modernization workflow only appears when Bob is opened at the `snapA-*` subfolder, NOT the parent `lab1-*` folder.

### 2. Confirm Agent mode

In Bob's chat panel, verify the mode indicator at the bottom shows **Agent**. (Agent is V2's default mode and replaces V1's `Advanced` and `Code` modes.)

### 3. Confirm the workflow appears

Look for the **Java Modernization** workflow in Bob's chat panel workflow list. If it's not visible, verify your team membership in Bob's settings.

---

# Exercise 1: Run the Liberty Replatforming Workflow

### Objective
Use Bob's Java Modernization workflow to migrate the pharmacy app from Traditional WebSphere to Liberty.

### Steps

1. **Start the workflow**
   - In Bob's chat panel, click **Start** on the Java Modernization workflow.

2. **Analyze Project screen**
   - The project path should auto-populate to the snapA folder.
   - Leave "Custom build command" blank.
   - Click **Continue**.

3. **Modernization Type screen**
   - Select **Liberty Replatforming**.
   - Leave **Enable Git Flow** unchecked (Git branch management should be done outside the workflow for this lab).
   - Click **Continue**.

4. **Provide the AMA migration plan**
   - Paste the full path to the migration plan ZIP file:
     ```
     [your local path]/Bobathon/labs/lab1-java-liberty-replatforming/simple-pharmacy.war_migrationPlan.zip
     ```
   - Click **Continue**.

5. **Interactive approval flow**
   - Bob will identify migration issues one at a time. For each, it will:
     - Explain the root cause of the issue
     - Propose a specific fix (usually a dependency change or config addition)
     - Ask for your approval
   - You'll typically see three options for each issue:
     - `Approve the fix and proceed with implementation`
     - `Do not change dependencies yet; inspect further`
     - `Approve the fix, but show me the exact edits before applying them`
   - **Recommendation**: for the first issue or two, pick the "show me the exact edits" option to see what Bob is proposing. For subsequent issues, approving directly is fine.
   - Expected issues on this project (may vary):
     - Javassist charset warning (dependency exclusion + upgrade)
     - OGNL SecurityManager conflict (dependency upgrade + JVM options file)
     - Liberty class-loading / CDI conflict (server.xml adjustments)

6. **Deployment**
   - After the fixes are applied, the workflow will build the app and deploy to Liberty.
   - Bob will report when the server is running and give you the URLs.

7. **Modernization summary**
   - Bob generates a visual modernization summary and prints per-task cost/token stats.
   - Confirm the workflow reports "started successfully with no errors" or select the appropriate option based on your logs.

---

# Exercise 2: Verify the Migrated Application

Open a browser and go to:
```
http://localhost:9080/simple-pharmacy.war/
```

You should see the pharmacy dashboard with data (prescriptions, orders, medicines).

Try navigating to:
- `http://localhost:9080/simple-pharmacy.war/dashboard`
- `http://localhost:9080/simple-pharmacy.war/prescription-list.action`
- `http://localhost:9080/simple-pharmacy.war/order-list.action`
- `http://localhost:9080/simple-pharmacy.war/medicine-list.action`

If all pages render, the migration is complete.

---

# Troubleshooting

## Issue 1: Maven Not Found After Installation

**Symptom:** `mvn: command not found`

**Solution:**
1. Verify SDKMAN installation: `sdk version`
2. Reinstall Maven: `sdk install maven`
3. Fully restart Bob (not just close the window)
4. Open a new terminal and verify: `mvn --version`

## Issue 2: Bob Terminal Uses Wrong Java Version

**Symptom:** `java -version` in Bob's terminal shows a different version than expected.

**Solution:** `sdk use java <identifier>` only applies to the shell it's run in. Bob's terminal is a separate shell. Run `sdk use java 8.0.492-zulu` in Bob's terminal specifically, or set the default with `sdk default java 8.0.492-zulu`.

## Issue 3: `SRVE0321E: The [struts2] filter did not load during start up`

**Symptom:** After Liberty deploys, the log shows a Struts2 filter loading error.

**Solution:** Safe to ignore. The migrated app functions correctly; the message reflects a class-loading side effect that doesn't affect runtime behavior.

## Issue 4: `CWWKS9660E: The orb element with the defaultOrb id attribute requires a user registry`

**Symptom:** ORB-related warning appears in Liberty logs.

**Solution:** Safe to ignore per the message itself, provided the app doesn't use ORB-based EJB components (this one doesn't).

## Issue 5: Workflow proposes a change but you're not sure

**Solution:** Any time Bob offers "show me the exact edits before applying them," pick that option. Bob will render the diff for your review before touching any files.

---

# Conclusion

Congratulations — you've completed the Liberty Replatforming lab using Bob V2's Java Modernization workflow. You should now be comfortable with:

- ✅ Launching a Bob V2 Java Modernization workflow
- ✅ Navigating the interactive approval flow for each migration change
- ✅ Reading Bob's per-task cost and modernization summary output
- ✅ Deploying and verifying a modernized Liberty application

Ready for Lab 2 (Java Upgrade) next.

---
