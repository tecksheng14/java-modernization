# IBM Bob AI Copilot - UI Modernization Lab Guide (V2)
## Simple Pharmacy Dashboard - Struts to Angular Migration

---

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [V2 Feature Highlights](#v2-feature-highlights)
4. [Setting Up](#setting-up)
5. [Exercise 1: Run the UI Modernization Workflow](#exercise-1-run-the-ui-modernization-workflow)
6. [Exercise 2: Verify the Migrated Application](#exercise-2-verify-the-migrated-application)
7. [Known Issues and Troubleshooting](#known-issues-and-troubleshooting)
8. [Conclusion](#conclusion)

---

# Introduction

### What is UI Modernization?

UI Modernization migrates a legacy server-rendered frontend (like Struts JSPs) to a modern single-page application (like Angular), with a REST API replacing the traditional action-based backend flow. Typical changes:
- **Framework migration**: Struts/JSP → Angular
- **Design system adoption**: raw HTML/CSS → a Material or component library
- **API layer split**: monolithic action controllers → REST endpoints returning JSON
- **Dev experience**: hot-reload dev server, TypeScript, component-based structure

## About This Lab

You'll use **Bob V2's Java Modernization workflow** with the **UI Modernization** sub-type to migrate the pharmacy application from Struts to Angular. Both frontend and backend are modernized in a single workflow run.

- **Before**: Liberty Runtime, Java 21, Struts (JSP views)
- **After**: Liberty Runtime, Java 21, Jakarta EE REST API + Angular 22 SPA (Material AI design system)

## Learning Objectives

By the end of this lab, you will:
- Configure the UI Modernization workflow with framework, design system, and project paths
- Observe how Bob adapts its behavior when a REST layer already exists (gap analysis vs full generation)
- Recognize auto-added features like MicroProfile OpenAPI and Swagger UI
- Diagnose and fix the known proxy/context path mismatch between the generated frontend and the deployed backend

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

### 3. Java 21
The `snapC-ui-mod` starting state is Java 21. Install with:
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
```bash
sdk install maven
```

### 5. Node.js and npm
Node.js 18+ and npm 9+. On macOS:
```bash
brew install node
node --version
npm --version
```

### 6. Angular CLI (with the npm user-prefix fix)

`npm install -g @angular/cli` will fail with EACCES on Homebrew-installed Node unless you route npm global installs to a user-owned directory first. Run these once:
```bash
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

Then install Angular CLI:
```bash
npm install -g @angular/cli
ng version
```

### 7. Restart Bob
Fully quit and restart Bob after installing Maven and Node so it picks up the tools.

---

# V2 Feature Highlights

Worth watching for and demonstrating during this lab:

- **UI Modernization as a sub-type**: it's not a standalone workflow; it lives inside the Java Modernization workflow. The workflow surface consolidates all four sub-types (Java Upgrade, Liberty Replatforming, UI Modernization, Java Unit Testing) into one entry point.
- **Structured setup screen**: a dedicated config screen with Frontend/Backend toggles, framework dropdowns (Angular, React, Vue), design system options (including "Material AI"), backend framework options (Jakarta EE style REST services, Spring Boot, Quarkus), and project path fields.
- **Autonomous state detection**: Bob detects that Liberty Replatforming isn't needed (application is already on Liberty) and greys that sub-type option out. When it detects an existing JAX-RS layer, it switches from full-generation mode into gap-analysis mode.
- **Auto-added Swagger UI**: the workflow adds MicroProfile OpenAPI and Swagger UI at `/openapi/ui/` — instant API documentation.
- **Design system adoption**: Bob rewrites plain HTML components into proper Angular Material (or Material AI) components with consistent styling.
- **Iterative build validation**: after generation, Bob compiles the frontend and backend and iterates to fix build errors before declaring the workflow complete.

---

# Setting Up

### 1. Open the snapshot subfolder as your project root
```
Bobathon/labs/lab3-ui-modernization/snapC-ui-mod
```
Use the `snapC-*` subfolder, not the parent `lab3-*` folder.

### 2. Confirm Agent mode
Bob's chat panel should show **Agent** at the bottom.

### 3. Create the frontend folder before starting the workflow

**Important**: the UI Modernization workflow requires both the frontend and backend folders to exist before you click Setup Project. The backend folder is already there (the snap root itself); the frontend folder isn't. Create it now:

```bash
cd Bobathon/labs/lab3-ui-modernization/snapC-ui-mod
mkdir frontend
```

If you skip this, the workflow stalls with no clear error.

---

# Exercise 1: Run the UI Modernization Workflow

### Steps

1. **Start the workflow**
   - Click **Start** on the Java Modernization workflow in Bob's chat panel.

2. **Analyze Project screen**
   - Confirm the auto-populated project path points at `snapC-ui-mod`.
   - Leave "Custom build command" blank.
   - Click **Continue**.

3. **Modernization Type screen**
   - You'll see four sub-types. **Liberty Replatforming** is greyed out with "Application is already using Liberty" — that's expected.
   - Select **UI Modernization**.
   - Leave **Enable Git Flow** unchecked.
   - Click **Continue**.

4. **Analyze Application Architecture**
   - Bob analyzes the codebase (Struts actions, JSPs, existing REST classes, models). This is a read-only pass.
   - Click **Continue** when prompted.

5. **Setup UI Modernization Project screen**
   Fill in these fields:

   **Modernization Configuration**
   - Check **Frontend Modernization**
   - Check **Backend Modernization**

   **Frontend**
   - **Frontend Framework**: `Angular`
   - **Frontend Design System**: `Material AI`
   - **Frontend Project Path**: absolute path to your `snapC-ui-mod/frontend/` folder

   **Backend**
   - **Backend Framework**: `Jakarta EE style REST services` (matches Liberty)
   - **Backend Project Path**: absolute path to `snapC-ui-mod/` itself

   Click **Setup Project**.

6. **Iterative generation and approval**
   - Bob generates the Angular project (models, services, components, routing, config).
   - It rewrites plain HTML components into Material components.
   - It generates or enhances the backend JAX-RS resources with input validation and OpenAPI annotations.
   - Any pom.xml changes (adding MicroProfile OpenAPI, adjusting server.xml features) surface as approval prompts. Approve them.

7. **Build validation**
   - Bob runs `mvn clean compile` and `ng build` to confirm both sides compile cleanly.
   - Total cost is typically around 5–10 Bob coins for this lab.

8. **Workflow summary**
   The final screen shows what was built, files created, and per-task cost/token stats.

---

# Exercise 2: Verify the Migrated Application

### 1. Start the backend

Open a terminal in the snap folder:
```bash
cd Bobathon/labs/lab3-ui-modernization/snapC-ui-mod
mvn liberty:run
```

Wait for `The defaultServer server is ready to run a smarter planet`.

### 2. Confirm the backend REST API works

In a separate terminal:
```bash
curl -i http://localhost:9081/simple-pharmacy.war/api/dashboard
```

You should get HTTP 200 with a JSON body containing prescriptions and orders.

### 3. Start the Angular dev server

In a second terminal:
```bash
cd Bobathon/labs/lab3-ui-modernization/snapC-ui-mod/frontend
npm start
```

Wait for `Application bundle generation complete`.

### 4. Open the app in a browser

Open `http://localhost:4200/`.

### 5. Verify

Click through: Dashboard, Prescriptions, Orders, Medicines. All pages should render data.

**If the dashboard is stuck loading and shows no data**, see [Known Issues](#known-issues-and-troubleshooting) — you've likely hit the proxy/context path mismatch.

### 6. Explore the auto-added Swagger UI

Open `http://localhost:9081/openapi/ui/` to see the Swagger UI Bob generated with your API documented.

---

# Known Issues and Troubleshooting

## Known workflow bug: proxy/context path mismatch

**Symptom**: Angular loads, but every page is stuck loading with no data. Browser DevTools Network tab shows `/api/*` requests returning HTTP 404, and the response body is Liberty's "Context Root Not Found" HTML page.

**Cause**: Bob's generated `proxy.config.json` sets `pathRewrite: "^/api" → "/simple-pharmacy/api"`, but Liberty actually deploys the WAR at `/simple-pharmacy.war/`. The two don't match, so every proxied request 404s.

**Fix**:
1. Open `snapC-ui-mod/frontend/proxy.config.json`.
2. Change:
   ```json
   "pathRewrite": {
     "^/api": "/simple-pharmacy/api"
   }
   ```
   to:
   ```json
   "pathRewrite": {
     "^/api": "/simple-pharmacy.war/api"
   }
   ```
3. Save, stop `npm start` (Ctrl+C), restart with `npm start`.
4. Hard-refresh the browser (Cmd+Shift+R).

## Issue: npm global install fails with EACCES

**Symptom**: `npm install -g @angular/cli` reports "The operation was rejected by your operating system."

**Solution**: Run the npm user-prefix setup from the [Prerequisites](#prerequisites) section. Do NOT use sudo.

## Issue: `SRVE0321E: The [struts2] filter did not load during start up`

**Symptom**: Struts filter warning in Liberty logs at startup.

**Solution**: Safe to ignore. Doesn't affect runtime behavior.

## Issue: OpenAPI validation warnings (CWWKO1650E)

**Symptom**: Liberty logs show warnings like "The Path Item Object must contain a valid path" for the OPTIONS operation on paths with `{id}` parameters.

**Solution**: Safe to ignore for lab purposes. The workflow's auto-generated CORS filter OPTIONS handlers don't declare their path parameters in OpenAPI annotations. It doesn't affect API functionality.

## Issue: Bob re-analyzes without applying a requested fix

**Symptom**: You tell Bob about a bug in the chat and ask it to fix, but Bob just re-reads files and reports "build looks clean" without touching anything.

**Solution**: Bob V2's follow-up conversation flow is unreliable for applied fixes. Apply the fix manually, then move on.

---

# Conclusion

You've completed the UI Modernization lab using Bob V2's Java Modernization workflow. You should now be comfortable with:

- ✅ Configuring the UI Modernization workflow (frontend, backend, framework, design system, paths)
- ✅ Pre-creating the frontend folder before Setup Project
- ✅ Interpreting Bob's adaptive behavior when a REST layer already exists
- ✅ Recognizing auto-added features (Swagger UI, Material components)
- ✅ Diagnosing and fixing the proxy/context path mismatch

Ready for Lab 4 (Unit Test Generation) next.

---
