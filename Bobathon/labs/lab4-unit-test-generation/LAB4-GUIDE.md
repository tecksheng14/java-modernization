# IBM Bob - Unit Test Generation Lab Guide (V2)

---

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [V2 Feature Highlights](#v2-feature-highlights)
4. [Setting Up](#setting-up)
5. [Exercise 1: Run the Java Unit Testing Workflow](#exercise-1-run-the-java-unit-testing-workflow)
6. [Exercise 2: Review the Test Strategy and Results](#exercise-2-review-the-test-strategy-and-results)
7. [Troubleshooting](#troubleshooting)
8. [Conclusion](#conclusion)

---

# Introduction

### What is Unit Test Generation?

Unit test generation uses Bob V2's dedicated **Java Unit Testing** workflow to automatically:
- Analyze your project and identify testable classes
- Draft a written test strategy explaining what will be tested and how
- Install and configure JaCoCo for code coverage
- Generate JUnit 5 tests with Mockito mocks and AssertJ assertions
- Run the generated tests and report the coverage baseline

## About This Lab

You'll use the standalone **Java Unit Testing** workflow to add a comprehensive test suite to the pharmacy app.

- **Before**: Liberty Runtime, Java 21, Angular frontend, no tests
- **After**: Same, with JUnit 5 test suite, JaCoCo coverage, and a `UNITTEST.md` strategy file

## Learning Objectives

By the end of this lab, you will:
- Launch the standalone Java Unit Testing workflow
- Understand each option on the task-selection screen
- Read Bob's `UNITTEST.md` test strategy file
- Interpret the cost/time preview and 80% confidence interval
- Review the coverage baseline Bob reports at the end

---

# Prerequisites

### 1. IBM Bob IDE (V2)
Latest Bob V2 IDE extension installed with the Java premium package on your plan.

### 2. Terminal Environment (macOS zsh)
Check that SDKMAN is set up:
```
sdk version
```

If SDKMAN isn't set up:
```bash
curl -s "https://get.sdkman.io" | bash
echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.zshrc
source ~/.zshrc
```

### 3. Java 21
```bash
sdk list java | grep " 21\."
```
Confirmed working on Apple Silicon: `21.0.11-zulu`.
```bash
sdk install java 21.0.11-zulu
sdk use java 21.0.11-zulu
java -version   # should show 21
```

### 4. Maven
Check if maven is installed already:
```
mvn -v
```

If not, install it:
```bash
sdk install maven
```

### 5. Restart Bob
Fully quit and restart Bob after installing Maven.

---

# Workflow Steps Highlights

1. **Project Analysis** — Scans the project structure, build tool, and existing test infrastructure (JUnit version, JaCoCo, Surefire plugin) to understand the starting state.

2. **Test Strategy Generation** — Produces a UNITTEST.md strategy document defining conventions: naming patterns, mocking approach, isolation rules, and scope.

3. **Task-selection screen**: choose whether to regenerate the strategy, generate tests, run coverage, and enable Git Flow. Includes a **Candidate Selection Strategy** dropdown (default: All classes).

4. **Cost/time preview**: before expensive operations, Bob shows expected duration and Bob-coin cost with an **80% confidence interval** — a rare bit of self-acknowledged variance in AI tooling.

5. **Test Generation** (Batched Subagents) — Spawns parallel subagents per package/batch, each reading the production class and UNITTEST.md to write focused JUnit 5 tests with Mockito mocks where needed.

6. **Build & Dependency Updates** — Adds missing test dependencies (junit-jupiter, mockito-core, mockito-junit-jupiter, JAX-RS runtime for container-free tests) to pom.xml as needed.

7. **Self-correcting recovery tasks**: if the workflow hits build issues mid-run (stale class files, compile race conditions, etc.), it adds unplanned recovery subtasks and fixes them without user prompting.

8. **Test Execution & Validation** — Runs mvn test and fixes any failures before proceeding, ensuring a green suite throughout.

9. **Coverage Reporting** — Runs the full suite with JaCoCo enabled and surfaces per-class instruction coverage, highlighting any remaining gaps.

---

# Setting Up

### 1. Open the snapshot subfolder as your project root
```
Bobathon/labs/lab4-unit-test-generation/snapD-unit-test-gen
```
Use the `snapD-*` subfolder, not the parent `lab4-*` folder.

### 2. Confirm Agent mode
Bob's chat panel should show **Agent** at the bottom.

### 3. Confirm the workflow appears
Look for **Java Unit Testing** in Bob's chat panel workflow list (it's a top-level workflow)

---

# Exercise 1: Run the Java Unit Testing Workflow

### Steps

1. **Start the workflow**
   - Click **Start** on the **Java Unit Testing** workflow in Bob's chat panel.

2. **Automatic setup**
   Bob will:
   - Detect that no code coverage tool is configured
   - Install JaCoCo into pom.xml
   - Read through the codebase to develop a testing strategy
   - Draft the test strategy, UNITTEST.md

   No approval prompts appear during this phase — this is expected.

3. **Task selection screen**
   Choose:
   - Leave **Re-generate Unit Test Strategy** unchecked (Bob just drafted one)
   - Check **Generate Unit Tests**
   - **Candidate Selection Strategy**: `All classes` (the default)
   - Check **Run Code Coverage**
   - Leave **Enable Git Flow** unchecked

   Click **Continue**.

4. **Cost/time preview**
   Bob shows something like:
   > "I will generate unit tests for 12 classes in 4 batches. For each batch, I expect a duration of 3 minutes and cost of 2.8 Bob coins (80% of batches finish within these limits)."

   Note the 80% confidence phrasing. Click **Proceed with test generation**.

5. **Batch generation**
   Bob generates tests in batches organized by package leveraging subagents with isolated contexts:
   - `com.pharmacy.repository` (3 classes)
   - `com.pharmacy.api` — first batch (1 class)
   - `com.pharmacy.model` (3 classes)
   - `com.pharmacy.api` — remaining classes (5 classes)

   If Bob hits build issues mid-run (stale `.class` files, incremental compile race), it will add recovery subtasks and fix them autonomously.

6. **Test execution and coverage report**
   After all batches complete, Bob runs `mvn test` and reports pass/fail counts, then generates a JaCoCo coverage report. If a report is not automatically generated or surfaced, just ask Bob `please generate a JaCoCo coverage report`

7. **Workflow summary**
   Bob prints a per-task cost breakdown and a modernization summary graphic. Typical actual cost lands well under the preview (e.g. ~4.5 coins vs an ~11 coin preview).

---

# Exercise 2: Review the Test Strategy and Results

### 1. Read `UNITTEST.md`

Open `UNITTEST.md` at the project root. Bob's strategy document covers:
- Application architecture summary
- Testable classes and their responsibilities
- Naming conventions
- Test file paths
- Coverage thresholds (goals, not guarantees)
- Identified gaps prioritized as P1/P2/P3

### 2. Run the test suite yourself

In Bob's terminal:
```bash
mvn clean test
```

Confirm the same pass rate Bob reported.

### 3. Open the coverage report

```bash
mvn jacoco:report
open target/site/jacoco/index.html
```

Compare package-level coverage numbers to Bob's reported baseline.

### 4. Explore a test file

Open a few generated test files (e.g. `src/test/java/com/pharmacy/repository/PrescriptionRepositoryTest.java`) and note:
- Use of `@ExtendWith(MockitoExtension.class)`
- `@Mock` and `@InjectMocks` annotations
- AssertJ fluent assertions

If repositories use the singleton pattern, look for how Bob mocks it — a common technique is `MockedStatic` combined with reflection to overwrite the private singleton field.

---

# Conclusion

You've completed the Unit Test Generation lab using Bob V2's Java Unit Testing workflow. You should now be comfortable with:

- ✅ Launching the standalone Java Unit Testing workflow
- ✅ Configuring the task-selection screen (strategy, tests, coverage)
- ✅ Reading Bob's cost/time preview with 80% confidence interval
- ✅ Reviewing the `UNITTEST.md` strategy document
- ✅ Interpreting the coverage baseline Bob reports at the end

Ready for Lab 5 (Vulnerabilities Detection) next.

---

## Troubleshooting

### Issue 1: `mvn test` reports "cannot find symbol" or missing classes

**Symptom:** Test classes reference source classes Bob thinks exist but the compile step disagrees.

**Solution:** Stale `.class` files from a prior run can cause this. Run `mvn clean test` (not just `mvn test`) to force a full recompile.

### Issue 2: Some generated tests fail

**Symptom:** After Bob completes, a small number of tests fail on `mvn test`.

**Solution:** Ask Bob in the chat to review and fix the failing tests specifically: "the following tests are failing: [paste output]. Please fix them without changing production code." Bob will iterate on the tests until they pass.

### Issue 3: JaCoCo coverage report doesn't appear

**Symptom:** No `target/site/jacoco/` directory after the run.

**Solution:** Run `mvn clean test jacoco:report`. The coverage report requires the `jacoco:report` goal explicitly.

### Issue 4: Bob's terminal shows the wrong Java version

**Symptom:** `java -version` in Bob's terminal shows 8 instead of 21.

**Solution:** `sdk use java 21.0.11-zulu` in Bob's terminal specifically. `sdk use` is shell-scoped and doesn't apply across terminal tabs.

---