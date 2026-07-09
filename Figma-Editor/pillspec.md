# Pill Tracker Application Specification

## Overview
A single-page application for tracking medication schedules across multiple users with real-time status updates and overdue alerts. This application is designed for a desktop view, and is all contained in a single frame in Figma.

---

## Core Features

### 1. Time Management
- **Current Time Display**: Show the current time prominently at the top of the page
- **Time Advance Button**: Button to simulate advancing time by 8 hours for testing purposes
- **Real-time Updates**: All prescription statuses, countdowns, and overdue calculations update based on current time

### 2. User Management
- **3 Sample Users**: Pre-configured with different prescriptions
- **User Selection**: Radio buttons to switch between users
- **User Information Display**:
  - User name
  - Age
  - Count of active prescriptions

### 3. Prescription Display

#### Container Layout
- **Vertical Organization**: Each prescription in its own container, stacked vertically
- **Sorting Priority**:
  1. Overdue prescriptions (top)
  2. On Schedule prescriptions (below overdue)
  3. Within each category, sort by next scheduled time (earliest first)

#### Prescription Information
Each prescription container must display:
- **Medication Name**
- **Dosage**: Amount and unit (e.g., "500mg", "10ml")
- **Frequency**: How often to take (e.g., "Every 8 hours", "Twice daily")
- **Scheduled Time**: Next time to take in HH:MM format
- **Simple Explanation**: Brief description of what the medication is for

#### Status Indicators
Located in the top-right corner of each container:

**On Schedule Status:**
- Display in a bubble/badge
- Show countdown timer (e.g., "Take in 2h 30m")
- Updates in real-time
- Neutral/positive visual styling

**Overdue Status:**
- Display in a bubble/badge
- Show how late (e.g., "Overdue by 1h 15m")
- Emphasized styling (bold, larger, red)
- Updates in real-time

#### Action Button
- **"Mark as Taken" Button**
- **Enabled State**: When prescription is due or overdue
- **Disabled State**: After marking as taken, until next scheduled time
- **Action**: Records the medication as taken and resets the schedule

### 4. Overdue Alert System

#### Banner Display
- **Location**: Top of the page, below time controls
- **Visibility**: Only shown when one or more prescriptions are overdue
- **Content**:
  - List which prescriptions are overdue
  - Prompt user to take medication immediately
  - Example: "⚠️ Overdue: Lisinopril (1h 30m late), Metformin (45m late). Please take these medications immediately."
- **Visual Effect**: Subtle red flash animation (pulsing or fading)
- **Priority**: Should be immediately noticeable but not jarring

---

## Sample Data Structure

### User 1: Sarah Johnson
- **Age**: 67
- **Prescriptions**: 3 active

1. **Lisinopril**
   - Dosage: 10mg
   - Frequency: Once daily
   - Scheduled Time: 08:00
   - Explanation: Blood pressure medication to help lower high blood pressure

2. **Metformin**
   - Dosage: 500mg
   - Frequency: Twice daily
   - Scheduled Times: 08:00, 20:00
   - Explanation: Diabetes medication to control blood sugar levels

3. **Atorvastatin**
   - Dosage: 20mg
   - Frequency: Once daily
   - Scheduled Time: 21:00
   - Explanation: Cholesterol medication to reduce risk of heart disease

### User 2: Michael Chen
- **Age**: 45
- **Prescriptions**: 2 active

1. **Levothyroxine**
   - Dosage: 75mcg
   - Frequency: Once daily
   - Scheduled Time: 07:00
   - Explanation: Thyroid hormone replacement for hypothyroidism

2. **Omeprazole**
   - Dosage: 20mg
   - Frequency: Once daily
   - Scheduled Time: 07:30
   - Explanation: Reduces stomach acid to treat heartburn and acid reflux

### User 3: Emma Rodriguez
- **Age**: 52
- **Prescriptions**: 4 active

1. **Amlodipine**
   - Dosage: 5mg
   - Frequency: Once daily
   - Scheduled Time: 09:00
   - Explanation: Calcium channel blocker for high blood pressure

2. **Sertraline**
   - Dosage: 50mg
   - Frequency: Once daily
   - Scheduled Time: 09:00
   - Explanation: Antidepressant to treat depression and anxiety

3. **Vitamin D3**
   - Dosage: 2000 IU
   - Frequency: Once daily
   - Scheduled Time: 09:00
   - Explanation: Supplement to maintain healthy bones and immune system

4. **Aspirin**
   - Dosage: 81mg
   - Frequency: Once daily
   - Scheduled Time: 21:00
   - Explanation: Low-dose blood thinner to prevent heart attack and stroke

---

## Technical Requirements

### Time Calculations
- Calculate time until next dose for "On Schedule" prescriptions
- Calculate time overdue for missed prescriptions
- Update all timers every minute (or more frequently for smooth countdown)
- Handle time advancement correctly (8-hour jumps)

### State Management
- Track which prescriptions have been taken
- Track last taken time for each prescription
- Prevent duplicate "taken" actions within the same schedule window
- Reset "taken" status when next scheduled time arrives

### Prescription Status Logic

**Overdue Criteria:**
- Current time is past the scheduled time
- Prescription has not been marked as taken for this schedule window

**On Schedule Criteria:**
- Current time is before the scheduled time
- OR prescription has been taken and next scheduled time hasn't arrived yet

**Disabled Button Criteria:**
- Prescription was marked as taken
- Next scheduled time has not yet arrived

### Visual Design Considerations
- Clear visual hierarchy (overdue > on schedule)
- Accessible color choices (not relying solely on color for status)
- Readable typography for elderly users
- Touch-friendly button sizes
- Responsive layout for different screen sizes

### Animation Requirements
- Smooth countdown updates
- Subtle red flash for overdue banner (2-3 second cycle)
- Smooth transitions when prescriptions change status
- No jarring or distracting animations

---

## User Interaction Flow

1. **Page Load**
   - Display current time
   - Default to first user (Sarah Johnson)
   - Show all prescriptions sorted by priority
   - Display overdue banner if applicable

2. **Switching Users**
   - Click radio button for different user
   - Update prescription list
   - Update overdue banner
   - Maintain current time

3. **Advancing Time**
   - Click "Advance 8 Hours" button
   - Update current time display
   - Recalculate all prescription statuses
   - Update countdowns and overdue times
   - Show/hide overdue banner as needed

4. **Marking Prescription as Taken**
   - Click "Mark as Taken" button
   - Disable button
   - Update prescription status
   - Remove from overdue banner if applicable
   - Schedule next dose

5. **Real-time Updates**
   - Countdowns decrease every minute
   - Overdue times increase every minute
   - Prescriptions automatically move from "On Schedule" to "Overdue"
   - Banner appears/updates when prescriptions become overdue

---

## Edge Cases to Handle

1. **Multiple prescriptions at same time**: Display in alphabetical order
2. **Prescription just taken**: Show "Taken" status with next scheduled time
3. **All prescriptions on schedule**: No overdue banner displayed
4. **Multiple overdue prescriptions**: List all in banner, separated by commas
5. **Time advancement causing multiple prescriptions to become overdue**: Update all statuses simultaneously
6. **Switching users while prescriptions are overdue**: Show correct overdue status for new user

---

## Success Criteria

- ✅ Users can easily see which medications are overdue
- ✅ Users can track when to take their next dose
- ✅ Users cannot accidentally double-dose
- ✅ Time simulation works correctly for testing
- ✅ Interface is clear and accessible for elderly users
- ✅ All prescription information is clearly displayed
- ✅ Overdue alerts are noticeable but not alarming
- ✅ The design is all contained in a single frame