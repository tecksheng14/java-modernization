# IBM Bob AI Copilot - Java Liberty Replatforming Lab Guide
## Simple Pharmacy Dashboard - WebSphere to Liberty Migration

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
- **Application Server**: WebSphere Application Server (TWas)

You'll modernize it to:
- **Application Server**: Liberty Application Server

## Learning Objectives

By completing this lab, you will use Bob to:
- Walkthrough the Java Modernization workflow which invloves
   - Analyzing legacy Java applications
   - Executing automated modernization transformations
   - Verifying and testing modernized applications

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

### 3. Java Development Kit (JDK)
Java 8 or higher is required for this application. If you don't have Java installed, follow these steps:

**Check if Java is Already Installed:**
```bash
java -version
```

If Java is not installed or you need a different version, install it using SDKMAN!:

**Installation Instructions (via SDKMAN!):**
```bash
# Install Java 8 (required for this lab)
sdk install java 8.0.432-tem

# Set it as the default version
sdk default java 8.0.432-tem
```

**Verify Java Installation:**
```bash
java -version
```

You should see output showing Java version 8 (e.g., `openjdk version "1.8.0_432"`).

**Alternative Installation Methods:**
- **macOS**: Download from [Adoptium](https://adoptium.net/) or use Homebrew: `brew install openjdk@8`
- **Windows**: Download from [Adoptium](https://adoptium.net/) and follow the installer
- **Linux**: Use your package manager (e.g., `apt install openjdk-8-jdk` on Ubuntu)

### 4. Maven (via SDKMAN!)
After installing SDKMAN! and Java, install Maven:

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


1. Launch your IDE with IBM Bob installed

2. Open the ```1_Java_Liberty_Replatforming``` project folder

3. If the Bob Chat window is not already open, select the Bob icon at the to the left of the search bar at the tope of your IDE.

4. At the bottom of the chat, you'll see the current mode (e.g., "💻 Code" or "❓ Ask"). Click on the current mode name at the bottom of the chat.

5. Select "☕ Java Modernization" from the dropdown menu. You should now be in Java Modernization mode, ready to begin the modernization process. Java modernization Workflows should also be an option if you want to click into that workflow.

---

## Exercise 2: Initiate the Java Modernization workflow

### Objective
Have Bob use the Java Modernization worklfow to analyze your current application, use a migration plan to upgrade the application, and validate the application post-upgrade.

### Steps

1. **Start the Workflow**
   
   * In the Bob chat window, you will see the **Java Modernization** workflow under **Workflows**. Selcet the **Start** button on the workflow to have Bob begin the Java modernization flow.

2. **Analyze**

   * **1.1 Analyze Java Project**
      
      Copy and Paste into the Project Path where your folder is located:
      ```
      bobathon/Bobathon/labs/lab1-java-liberty-replatforming/snapA-java-liberty-replatforming
      ```

   * **1.2 Select Java modernization type**
   
      Select **Liberty Replatforming** for modernization type. Toggle **Git Flow** off.

3. **Upgrade**

   a. **Liberty Replatforming**
   
   * **2.0 Run Liberty Modernization Analysis**

      Provide the path to the Application modernization Accelerator Deployment Plan ZIP file (**simple-pharmacy.war_migrationPlan.zip**) and select **Analyze Liberty Migration**. Bob will analyze the plan and create a Todo List for modernization.

   * **2.1 Run Liberty Re-Platforming recipes**

      Click **Run Recipes** to upgrade your Java code for Liberty


   * **2.2 Perform agentic upgrade**

      Bob will proceed with the upgrade task involving several subtasks. Bob will create a to do list(s) and complete tasks agentically, while also allowing user intervention and approvals.


3. **Validate**

   Select the option for Bob to Validate and/or Deploy your application

4. **Optional: Run the application**
   Prompt Bob to run the Simple Pharmacy application. Follow the URL the Bob provides to view the UI of the local application.


---

# Troubleshooting

## Issue 1: Maven Not Found After Installation

**Symptom:**
```
mvn: command not found
```

**Solution:**
1. Verify SDKMAN! installation: `sdk version`
2. Reinstall Maven: `sdk install maven`
3. **Restart your IDE/Bob completely**
4. Open new terminal and verify: `mvn --version`


## Issue 2: Bob Can't Read Project Files

**Symptom:**
Bob says "I cannot access that file" or "File not found"

**Solution:**
1. Verify you're in the correct directory
2. Check file permissions: `ls -la`
3. Ensure Bob has read access to the workspace
4. Try referencing files with `@filename` syntax

## Issue 3: Error: Unable to access jarfile when providing AMA zip file path in Liberty Modernization

**Symptom:**
```
Error: Unable to access jarfile /Applications/IBM Bob.app/Contents/Resources/app/extensions/bob-code/assets/jars/ta-jam-2.2.1.jar
```

**Solution:**
1. Create a ```jars``` folder in your Bob application folder, in your Applications folder(```/Applications/IBM Bob.app/Contents/Resources/app/extensions/bob-code/assets```)
2. Add the ```ta-jam-2.2.1.jar``` and ```prompt-lib-2.2.0.jar``` files using the following file structure
   ```
   ├── jars/
   │   └── prompt-lib/
   │       ├── prompt-lib-2.2.0.jar/
   │   └── ta-jam-2.2.1.jar
   ```
3. Close and restart Bob

   **Caution:** Make sure Bob is not running from /Volumes (mounted .dmg). Move the IBM BoB app to the /Applications folder and run it from there; otherwise it will not be allowed to create folders or place .jar files.
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
✅ Use Bob's Java Modernization mode to analyze and upgrade the Pharmacy application and validate its modeernization

---