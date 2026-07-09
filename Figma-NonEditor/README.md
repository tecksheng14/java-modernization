# Figma Integration Lab - Without Editor Access

**Box Folder Link:** [https://ibm.ent.box.com/folder/373364692035](https://ibm.ent.box.com/folder/373364692035)

## 📋 Overview

This lab teaches you how to integrate IBM Bob with Figma when you **do NOT have editor access** to Figma files. You'll learn to use IBM Bob to read Figma designs, extract information, and work with design specifications without modifying the original files.

## 🎯 What You'll Learn

- Connect IBM Bob to Figma with read-only access
- Use IBM Bob to analyze Figma designs
- Extract design specifications and assets
- Work with Figma data in your development workflow
- Build applications based on Figma designs

## ⏱️ Duration

**30-45 minutes**

## 📚 Prerequisites

### Required
- IBM Bob installed in your IDE
- Figma account (free or paid)
- Read access to a Figma design file

### Recommended Knowledge
- Basic understanding of Figma
- Familiarity with IBM Bob
- Basic web development knowledge (HTML, CSS, JavaScript)

## 📖 Lab Guide

The complete lab guide is available as a PDF in this folder:
- **Pill Tracker Lab - Quick Reference Guide Final.pdf**

Open this PDF to follow the step-by-step instructions.

## 🚀 Quick Start

1. **Open the PDF guide** in this folder
2. **Set up Figma read access** following the guide's instructions
3. **Configure IBM Bob** for Figma integration
4. **Follow the exercises** to build the Pill Tracker app
5. **Complete the lab** and verify your results

## 📁 Files in This Folder

- `Pill Tracker Lab - Quick Reference Guide Final.pdf` - Complete lab instructions
- `initial_pill_tracker.png` - Screenshot of the initial design
- `edited_pill_tracker.png` - Screenshot of the final result
- `index.html` - HTML file for the Pill Tracker app
- `script.js` - JavaScript functionality
- `styles.css` - CSS styling
- `docker-compose.yml` - Docker configuration for running the app
- `database/` - Database initialization scripts
- `drupal/` - Drupal integration files (optional)
- `frontend/` - Frontend application files

## 💡 What You'll Build

You'll build a **Pill Tracker application** that helps users manage their medication schedule. The app includes:
- Medication list display
- Pill tracking functionality
- User-friendly interface based on Figma designs
- Database integration

## 🏃 Running the Application

### Option 1: Using Docker (Recommended)
```bash
cd Figma-NonEditor
docker-compose up
```
Then open http://localhost in your browser.

### Option 2: Direct HTML
```bash
cd Figma-NonEditor
# Open index.html in your browser
open index.html  # macOS
start index.html # Windows
xdg-open index.html # Linux
```

## 🆘 Troubleshooting

**Problem: Can't access Figma file**
- Verify you have at least view permissions
- Check your Figma account is logged in
- Ensure the file link is correct

**Problem: IBM Bob not connecting to Figma**
- Verify Figma API token is configured
- Check network connectivity
- Restart IBM Bob

**Problem: Docker not starting**
- Verify Docker is installed and running
- Check port 80 is not in use
- Review docker-compose logs: `docker-compose logs`

**Problem: Application not displaying correctly**
- Clear browser cache
- Check browser console for errors
- Verify all files are present

## 📞 Need Help?

- Review the PDF guide's troubleshooting section
- Check IBM Bob documentation
- Refer to the main repository [GETTING_STARTED.md](../GETTING_STARTED.md)

## 🔗 Related Labs

- **Figma-Editor**: Try this lab if you have editor access to Figma
- **Lab 3 (UI Modernization)**: Learn about frontend modernization with Angular

## 🎨 Design Assets

The lab includes before/after screenshots:
- `initial_pill_tracker.png` - Starting design
- `edited_pill_tracker.png` - Final implementation

Use these to compare your progress!

---

**Ready to start?** Open the PDF guide and begin building with Figma designs! 💊