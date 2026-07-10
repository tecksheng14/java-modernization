# IBM Bob AI Copilot - Lab 3: Java UI Modernization Workflow
## Simple Pharmacy — Legacy UI Modernization

---

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Initiating the Java UI Modernization Workflow](#initiating-the-java-ui-modernization-workflow)
4. [Step-by-Step Exercises](#step-by-step-exercises)
5. [Troubleshooting](#troubleshooting)
6. [Conclusion](#conclusion)

---

# Introduction

### What is the Java UI Modernization Workflow?

The Java UI Modernization workflow is a guided, AI-assisted process inside IBM Bob that helps teams modernize legacy Java web UIs. In this lab, the workflow is applied to [`snapC-ui-mod`](snapC-ui-mod) — a Simple Pharmacy application whose UI is built on Struts/JSP server-side rendering.

The workflow covers:
- **Analysis**: Examining the existing Struts/JSP codebase — components, routing, state, data, and layout patterns
- **Planning**: Producing a modernization plan and presenting target-state options for the UI
- **Code Generation**: Generating the selected target-state UI and integrating it with the existing application backend
- **Validation**: Running and testing the modernized UI against the live backend

## About This Lab

You will use IBM Bob to initiate and follow the Java UI Modernization workflow on the [`snapC-ui-mod`](snapC-ui-mod) application. The starting point is:
- **UI**: Struts/JSP server-side rendering

During the workflow, Bob will analyze the application and propose one or more target-state options. You will review those options and choose the one you want Bob to implement.

## Learning Objectives

By completing this lab, you will:
- Understand how to initiate and follow the Java UI Modernization workflow in Bob
- Use Bob to analyze a legacy Struts/JSP application and review target-state options
- Guide Bob through generating and refining the selected modernized UI
- Run and test the modernized application end-to-end

---

# Prerequisites

## Required Software

### 1. IBM Bob IDE
- Ensure you have IBM Bob latest version installed and are logged in
- Ensure you have access to **Agent mode** (required to initiate the workflow)

### 2. Java and Maven
The Liberty backend must be built and running for the modernized UI to connect to application data.

**Verify:**
```bash
java -version
mvn -version
```
You should see Java 17+ and Maven 3.x.

### 3. Additional tools based on selected target state
The workflow may recommend a target state that requires additional tools or runtimes. Install those tools if Bob indicates they are needed for the option you select.

---

# Initiating the Java UI Modernization Workflow

## Opening the Workspace

1. Open the [`snapC-ui-mod`](snapC-ui-mod) folder in Bob as your active workspace.
2. Open the Bob Chat interface.

## Switching to Agent Mode

The Java UI Modernization workflow runs in Bob's **Agent mode**, which provides:
- Multi-file read and write operations
- Complex multi-step workflow execution
- Deep knowledge of legacy Java UI patterns and modern UI modernization approaches

**To switch to Agent mode:**
1. Click on the current mode indicator at the bottom of the Bob chat window.
2. Select **Agent** from the dropdown.

![agent_mode](images_lab3UImodernization/agent_mode.png)

## Triggering the Workflow

In the Bob chat window, type the following to start the workflow:

```
I want to modernize this Java application UI. Help me execute the Java UI Modernization workflow.
```

Bob will initiate the Java UI Modernization workflow and begin with the analysis phase.

![ui_workflow](images_lab3UImodernization/ui_workflow.png)

---

# Step-by-Step Exercises

1. **Open Bob Chat**
   - Click the Bob icon in the IDE sidebar if the chat is not already open.

2. **Switch to Agent Mode**
   - Click the current mode indicator at the bottom of chat.
   - Select **Agent** from the dropdown and confirm if prompted.

3. **Initiate the Workflow**
   - In the Bob chat, enter:
     ```
     I want to modernize this Java application UI. Help me execute the Java UI Modernization workflow.
     ```

4. **Review the Analysis and Target-State Options**

   Bob will analyze the existing application and present target-state options for modernizing the UI. Review the proposed options and choose the one that best fits your goals for the lab.

![ui_options](images_lab3UImodernization/ui_options.png)


5. **Follow and Guide the Workflow**

   After selecting a target state, Bob will continue the modernization workflow and ask for your approval at key points. You are encouraged to prompt Bob throughout the process. Useful follow-up prompts include:
   - Asking Bob to explain a generated file or component
   - Requesting changes to the layout or structure
   - Asking Bob to troubleshoot build or runtime errors
   - Asking for clarification on a modernization decision

6. **Start the Backend**

   Once Bob has generated the modernized UI, start the Liberty backend so you can validate the full application:

   ```bash
   # From snapC-ui-mod
   ./run-liberty.sh       # macOS/Linux
   run-liberty.bat        # Windows
   ```

   See [`README-AUTOMATION.md`](snapC-ui-mod/README-AUTOMATION.md) for full backend startup and stop instructions.

7. **Validate the Modernized UI**

   Once Bob completes the workflow, ask Bob to help run the application:
   ```
   Help me run the modernized application UI
   ```

   If the selected target state requires additional commands or tools, follow the instructions Bob provides for that option.

### Expected Outcome

- A successfully generated modernized UI based on the selected target-state option
- Core application pages and navigation working correctly
- The modernized UI able to retrieve data from the Liberty backend
- A validated end-to-end modernization result for the selected target state

---

# Troubleshooting

## Issue 1: Workflow Request Failed

**Symptom:**
```
{"apiProtocol":"openai"}
```

**Solution:**
Select "Retry" in the Bob chat window.

---

## Issue 2: Backend Connection Issues

**Symptom:**
The modernized UI cannot connect to the backend API. Errors may include:
- `HTTP Error: Connection refused`
- `Failed to load resource: net::ERR_CONNECTION_REFUSED`
- `CORS policy error`
- API calls returning 404 or timeout errors

**Root Cause:**
The Liberty backend is not running on the expected local endpoint, so the modernized UI cannot retrieve application data.

### Solution A: Start the Backend

```bash
cd snapC-ui-mod

# Full build and start (first time or after code changes)
./run-liberty.sh       # macOS/Linux
run-liberty.bat        # Windows

# Quick start (already built)
./quick-start.sh
```

Verify the backend is up:
```bash
curl http://localhost:9081/simple-pharmacy.war/api/dashboard
```

### Solution B: Stop a Stale Server

If port 9081 is already occupied:
```bash
./stop-liberty.sh      # macOS/Linux
stop-liberty.bat       # Windows
make stop              # using Make
mvn liberty:stop       # using Maven
```

### Solution C: Review Target-State Runtime Instructions

If the generated UI does not start or connect correctly, ask Bob to explain the runtime steps for the selected target state and verify that any required configuration, ports, proxies, or environment settings were applied correctly.

### Solution D: CORS Configuration

If CORS errors appear when hitting the backend directly, verify [`src/main/java/com/pharmacy/api/CorsFilter.java`](snapC-ui-mod/src/main/java/com/pharmacy/api/CorsFilter.java) includes:

```java
response.setHeader("Access-Control-Allow-Origin", "*");
response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
```

Restart the backend after any CORS changes.

### Verification After Applying a Fix

1. Check the browser console (F12) for remaining errors.
2. Navigate through the main application pages.
3. Verify data loads correctly in the modernized UI.

---

## Getting Help

### During the Lab
1. **Ask Bob** — provide the full error message for the most accurate assistance
2. **Ask Your Instructor** — raise your hand if you are stuck
3. **Collaborate** — discuss with classmates

### Bob-Specific Tips
- Be specific — include file names, error text, and what you already tried
- Ask Bob to explain its reasoning when reviewing generated code
- Request step-by-step guidance for complex debugging tasks

---

# Conclusion

You have completed Lab 3 — the Java UI Modernization workflow applied to the Simple Pharmacy application.

You should now be able to:

✅ Initiate the Java UI Modernization workflow in IBM Bob  
✅ Review and choose from the target-state options proposed by Bob  
✅ Guide Bob through generating and validating a modernized UI for the selected target state  

## Key Takeaways

1. **Java UI Modernization Workflow** — Bob's guided workflow helps modernize legacy Java UIs with minimal manual setup
2. **Target-State Choice** — The workflow can present multiple UI modernization options for the user to evaluate
3. **Phased Approach** — Analysis → Planning → Generation → Validation produces predictable, reviewable results
4. **Backend Continuity** — The existing Liberty backend continues to support the modernized UI during validation
5. **Iterative Guidance** — Users can guide Bob throughout the workflow to refine the generated result

## Next Steps (Optional)

> The following are optional extensions if you have additional time or want to deepen your exploration.

1. **Optimize the Generated UI**
   ```
   Optimize the generated UI for the selected target state
   ```

2. **Review Code Quality**
   ```
   Review the migrated code for architecture, maintainability, error handling, code organization, and documentation completeness
   ```

3. **Create a Modernization Summary**
   ```
   Create a MIGRATION_SUMMARY.md document that includes what was modernized, the selected target state, key architectural changes, known issues, and next steps
   ```

---

**Thank you for completing Lab 3!** You have used IBM Bob's Java UI Modernization workflow to analyze a legacy Java UI, choose a target state, and validate the resulting modernization outcome end-to-end.