# IBM Bob AI Copilot - Java Upgrade Lab Guide
## Simple Pharmacy Dashboard - Java 8 to Java 21 Upgrade

---

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Java Modernization Workflow](#java-modernization-workflow)
4. [Step-by-Step Exercises](#step-by-step-exercises)
5. [Troubleshooting](#troubleshooting)
6. [Conclusion](#conclusion)

---

# Introduction

### What is This Application?

The **Simple Pharmacy Management System** is a web-based application designed to manage pharmacy operations including:
- **Prescriptions**: Create and validate patient prescriptions
- **Orders**: Process medication orders and payments
- **Medicines**: Manage medicine inventory
- **Dashboard**: Monitor pending prescriptions and orders

### What is Java Modernization?

Java Modernization is the process of upgrading legacy Java applications to modern versions and platforms. This typically involves:
- **Java Version Upgrade**: Moving from older Java versions (like Java 8) to newer LTS versions (like Java 21)
- **Application Server Migration**: Transitioning from traditional servers (like WebSphere) to lightweight runtimes (like Liberty)
- **Dependency Updates**: Modernizing libraries and frameworks to current, supported versions
- **Code Transformation**: Updating code patterns to leverage modern Java features

## About This Lab

In this lab, you'll use IBM Bob's **Java Modernization mode** to modernize a legacy pharmacy management application. The application currently runs on:
- **Java Version**: 8

You'll modernize it to:
- **Java Version**: 21

## Learning Objectives

By completing this lab, you will use Bob to:
- Walkthrough the Java Modernization workflow which invloves
   - Analyze legacy Java applications
   - Execute automated modernization transformations
   - Verify and test modernized applications

---

# Prerequisites

## Required Software

Before starting this lab, ensure you have the following installed:

### 1. IBM Bob IDE
- Ensure you have IBM Bob latest version installed
- Login through Bob to get connected

### 2. SDKMAN! (SDK Manager)
SDKMAN! is a tool for managing parallel versions of multiple Software Development Kits on Unix-based systems.

**Installation Instructions:**
```bash
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

**Verify Installation:**
```bash
sdk version
```

You should see output like: `SDKMAN! 5.x.x`

**For detailed instructions, visit:** https://sdkman.io/install/

### 3. Maven (via SDKMAN!)
After installing SDKMAN!, install Maven:

```bash
sdk install maven
```

**Verify Maven Installation:**
```bash
mvn --version
```

You should see Maven version information along with the Java version that Maven is using.

**Important Note on Java Versions:**
When you run `mvn --version`, it shows the Java version that Maven will use to build your project. This may differ from your system's default Java version (shown by `java -version`). Maven uses the Java version specified by the `JAVA_HOME` environment variable or the Java installation that SDKMAN! has configured.

## Important: Restart Bob After Maven Installation

**⚠️ CRITICAL STEP:** After installing Maven via SDKMAN!, you **MUST** close and restart IBM Bob (or your IDE) for the changes to take effect. This ensures Bob can detect and use the newly installed Maven.

**To restart Bob:**
1. Close your IDE completely
2. Reopen your IDE
3. Verify Maven is detected by running the command to verify its installation in Bob's terminal

---

# Java Modernization Workflow

## Overview of Bob's Java Modernization Mode

IBM Bob's Java Modernization mode follows a structured workflow:

* **Analyze**
   * Bob analyzes your Java project and allows you to select a modernization type (Liberty Replatforming or Java Upgrade)
* **Upgrade**
   * Bob performs agentic upgrade of your Java prohject accoridng to the selected modernization type
* **Validate**
   * Bob validates your project's migration

## Auto-Approval Settings
You can control what Bob does automatically:
- **Read**: Let Bob read files without asking
- **Write**: Let Bob modify files without asking
- **Execute**: Let Bob run commands without asking
- **Todo**: Let Bob create task lists without asking

**Tip for Users:** Start with only "Read" enabled until you're comfortable!

---

# Step-by-Step Exercises

## Exercise 1: Open the Project & Activate Java Modernization Mode

### Objective
Open the correct project folder in your IDE and switch Bob into Java Modernization mode.

### Steps

1. **Launch your IDE** with IBM Bob installed.

2. **Open the project folder** in your IDE.

   The project you will be working on is located at:
   ```
   Bobathon/labs/lab2-java-upgrade/snapB-java-upgrade
   ```

   > **Tip:** Go to **File → Open Folder…** and navigate to the `snapB-java-upgrade` directory. Make sure you open **this specific subfolder** as your workspace root — not the parent `lab2-java-upgrade` folder. Bob uses the open workspace to determine which project to analyze.

   Once opened, you should see the following files and folders in your Explorer panel:
   ```
   snapB-java-upgrade/
   ├── pom.xml
   ├── src/
   ├── Dockerfile
   ├── run-liberty.sh
   └── ...
   ```

3. **Open the Bob Chat panel.**

   If the Bob Chat window is not already visible, click the Bob icon to the left of the search bar at the top of your IDE.

4. **Switch to Java Modernization mode.**

   At the bottom of the Bob Chat panel, you will see the currently active mode (e.g., `💻 Agent` or `❓ Ask`). Click on that mode name to open the mode selector dropdown.

5. **Select "☕ Java Modernization"** from the dropdown list.

   You should now see `☕ Java Modernization` displayed at the bottom of the chat panel, confirming you are in the correct mode and ready to proceed.

### Potential Issues
- **Wrong folder opened?** If Bob cannot find your `pom.xml`, close the workspace and re-open the `snapB-java-upgrade` subfolder directly.

---

## Exercise 2: Initiate the Java Modernization workflow

### Objective
Have Bob use the Java Modernization worklfow to analyze your current application, use a migration plan to upgrade the application, and validate the application post-upgrade.

### Steps

1. **Start the Workflow**
   
   * In the Bob chat window, you will see the **Java Modernization** workflow under **Workflows**. Selcet the **Start** button on the workflow to have Bob begin the Java modernization flow.

2. **Analyze**

   * **1.1 Analyze Java Project**
      
      Ensure that the Project Path that Bob populates in the you current project dirctory and select **Analyze Project**.

   * **1.2 Select Java modernization type**
   
      Select **Java Upgrade** for modernization type. Toggle **Git Flow** off.

3. **Upgrade**

   a. **Java Upgrade**
   
   * **2.1 Run Java upgrade recipes**

      Select your **Java 21** as your target. Toggle Jakarta EE migration option off and click **Run Recipes**.

* **2.2 Perform agentic upgrade**

   Bob will proceed with the upgrade task involving several subtasks. Bob will create a to do list(s) and complete tasks agentically, while also allowing user intervention and approvals.


3. **Validate**

   Select the option for Bob to Validate your application

4. **Run the application**

   You can ask Bob to run the application for you by typing in the chat:
   > *"Please run the Simple Pharmacy application"*

   Bob will execute the build and start the Liberty server, then provide the URLs to access the UI.

   Alternatively, you can run it manually from inside the `snapB-java-upgrade` folder:

   **Option A — Shell script (recommended):**
   ```bash
   # Make the script executable (first time only)
   chmod +x run-liberty.sh

   # Build and start Liberty
   ./run-liberty.sh
   ```

   **Option B — Maven directly:**
   ```bash
   mvn clean package
   mvn liberty:run
   ```

   The server takes 10–30 seconds to start. Once it is ready, open any of the following URLs in your browser:

   | Page | URL |
   |------|-----|
   | Dashboard | http://localhost:9081/simple-pharmacy.war/dashboard |
   | Prescriptions | http://localhost:9081/simple-pharmacy.war/prescription-list |
   | Orders | http://localhost:9081/simple-pharmacy.war/order-list |
   | Medicines | http://localhost:9081/simple-pharmacy.war/medicine-list |

   **To stop the server**, press `Ctrl+C` in the terminal, or run `./stop-liberty.sh` from a separate terminal.


---

# Troubleshooting

## Issue 1: Bob Can't Read Project Files

**Symptom:**
Bob says "I cannot access that file" or "File not found"

**Solution:**
1. Verify you're in the correct directory
2. Check file permissions: `ls -la`
3. Ensure Bob has read access to the workspace
4. Try referencing files with `@filename` syntax



---
## Getting Help

### During the Lab
1. **Check Troubleshooting Section** - Most common issues are covered
2. **Ask Bob** - Bob can help explain errors and suggest fixes
3. **Ask Your Instructor** - Don't hesitate to raise your hand
4. **Collaborate** - Discuss with classmates 

---

# Conclusion

Congratulations! You've completed the Java Modernization lab. You should now be able to:

✅ Set up prerequisites (SDKMAN!, Maven)  
✅ Use Bob's Java Modernization mode to analyze and upgrade the Pharmacy application and validate its modernization

---