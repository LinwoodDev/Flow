# Feature Specification: Repeatable / Recurring Tasks

## Overview

This feature introduces recurring tasks to Flow, allowing users to create tasks that automatically repeat on a defined schedule.

Examples:

- Clean room every week
- Pay rent every month
- Water plants every 2 days
- Team meeting every Monday
- Review notes every Friday

The goal is to allow users to complete a task while preserving history and automatically generating the next occurrence according to a recurrence rule.

---

# Problem Statement

Currently, tasks are one-time items.

Once a task is marked as completed:

- It remains completed forever.
- Users must manually recreate the task.
- Historical completion tracking is difficult.
- Common productivity workflows are not supported.

Recurring tasks solve this by allowing Flow to automatically schedule future occurrences.

---

# Design Goals

## Primary Goals

- Support recurring tasks.
- Preserve completion history.
- Work across all supported storage providers.
- Integrate with existing alarm system.
- Remain compatible with local and remote sources.
- Support offline-first synchronization.

## Non-Goals

- Complex enterprise scheduling.
- Cron-like expressions.
- AI-generated schedules.

---

# Recommended Approach

Instead of resetting a completed task, create a new occurrence when a recurring task is completed.

### Why?

Resetting the same task causes:

- Loss of completion history
- Incorrect statistics
- Difficult synchronization
- Ambiguous audit trail

Creating a new occurrence provides:

- Full history preservation
- Better synchronization
- Easier analytics
- More predictable behavior

---

# Domain Model Changes

## Recurrence Rule

Introduce a recurrence definition attached to supported task entities.

A recurrence rule describes:

- Frequency
- Interval
- End conditions
- Optional weekday restrictions

Examples:

| Rule | Meaning |
|--------|---------|
| Daily | Every day |
| Weekly | Every week |
| Monthly | Every month |
| Yearly | Every year |
| Every 2 Days | Interval = 2 |
| Every Monday | Weekly + Monday |
| Every Monday & Friday | Weekly + Multiple weekdays |

---

## Recurrence Metadata

Each recurring task should store:

### Frequency

Determines recurrence unit.

Examples:

- Daily
- Weekly
- Monthly
- Yearly

---

### Interval

Defines how often recurrence happens.

Examples:

- Every day = 1
- Every 2 days = 2
- Every 3 weeks = 3

---

### Start Date

The first occurrence date.

---

### End Condition

Supported options:

#### Never Ends

Default behavior.

#### End After X Occurrences

Example:

- Repeat weekly
- Stop after 20 occurrences

#### End On Date

Example:

- Repeat monthly
- Stop on December 31st

---

### Weekday Selection

Used for weekly recurrence.

Examples:

- Monday
- Friday
- Monday + Wednesday + Friday

---

# Task Lifecycle

## Creating a Recurring Task

User creates:

"Clean Room"

Settings:

- Repeat: Weekly
- Day: Sunday

System stores:

- Original task
- Associated recurrence rule

---

## Completing a Recurring Task

User completes:

"Clean Room"

System:

1. Marks current occurrence as completed.
2. Calculates next occurrence.
3. Creates a new occurrence.
4. Schedules alarms for the new occurrence.
5. Persists changes locally.
6. Syncs changes to active sources.

---

## Future Occurrence Generation

Generation may happen:

### Option A (Recommended)

Immediately after completion.

Advantages:

- Simple implementation
- Predictable sync behavior
- Works offline

---

### Option B

Background generation.

Advantages:

- Less storage usage

Disadvantages:

- More complexity

Not recommended for initial release.

---

# Architecture Integration

## flow_api

### New Domain Objects

Introduce recurrence-related models inside:

```
api/lib/models/
```

Potential concepts:

- RecurrenceRule
- RecurrenceFrequency
- RecurrenceEndCondition

These remain storage-agnostic.

---

## SourcesService Integration

Recurring tasks must behave identically across all sources.

Supported providers:

- SQLite
- CalDAV
- iCal
- Future providers

Responsibilities:

- Store recurrence metadata
- Generate next occurrence
- Sync recurrence state

---

## Database Layer

Migration required.

SQLite schema must support:

- Recurrence configuration
- Parent recurring task references
- Occurrence tracking

Migration should be versioned using existing migration infrastructure.

---

# Occurrence Tracking

Each generated task should reference its originating recurring series.

Benefits:

- Group occurrences together
- Show task history
- Allow editing future occurrences

Example:

Series:

"Clean Room"

Occurrences:

- July 1
- July 8
- July 15
- July 22

All belong to the same recurring series.

---

# Editing Behavior

## Edit This Occurrence

Only affects selected task.

Example:

Move this week's cleaning to Tuesday.

Future occurrences remain unchanged.

---

## Edit Entire Series

Updates recurrence rule.

Example:

Change:

Weekly

To:

Monthly

Future occurrences follow new rule.

Past occurrences remain unchanged.

---

# Deletion Behavior

## Delete Occurrence

Removes only one occurrence.

Series remains active.

---

## Delete Series

Removes recurrence configuration.

Future occurrences are no longer generated.

Existing completed occurrences remain for historical purposes.

---

# Alarm System Integration

AlarmCubit must support recurring tasks.

When a new occurrence is generated:

- Existing notification completed.
- New notification scheduled.
- Reminder settings copied.

Example:

Task:

Take medicine daily at 8:00 AM

After completion:

- Today's reminder completed.
- Tomorrow's reminder automatically scheduled.

---

# UI Requirements

## Task Creation Screen

Add:

### Repeat Section

Options:

- Does not repeat
- Daily
- Weekly
- Monthly
- Yearly
- Custom

---

### Custom Configuration

Show:

- Interval selector
- Weekday selector
- End condition selector

---

## Task Details Screen

Display:

Examples:

- Repeats daily
- Repeats every 2 weeks
- Repeats on Monday and Friday
- Ends after 20 occurrences

---

## Task History

Optional future enhancement.

Show:

- Previous completions
- Completion dates
- Missed occurrences

---

# Synchronization Considerations

Because Flow supports multiple sources:

- Local source may create occurrence first.
- Remote source may already contain occurrence.
- Sync engine must avoid duplicate generation.

Recommended:

Assign recurring series identifiers and occurrence identifiers.

This allows deterministic synchronization.

---

# Edge Cases

## Missed Occurrences

Example:

Task repeats daily.

User opens app after 7 days.

Possible strategies:

### Generate All Missed Occurrences

Creates:

- Day 1
- Day 2
- Day 3
- Day 4
- Day 5
- Day 6
- Day 7

Advantages:

- Accurate history

Disadvantages:

- Potential clutter

---

### Generate Only Next Occurrence (Recommended MVP)

Creates only the next valid occurrence.

Simpler implementation.

---

## Timezone Changes

Recurrence calculations should use local timezone.

Task schedule should remain logically consistent after travel.

---

## DST Changes

Ensure recurrence calculations remain date-based rather than duration-based.

Example:

Daily recurrence should remain at 9:00 AM after daylight saving changes.

---

# Future Enhancements

- Recurring notes
- Recurring events
- Habit tracking
- Completion streaks
- Statistics dashboard
- RRULE compatibility (RFC 5545)
- Natural language scheduling
  - Every weekday
  - Every first Monday
  - Every 3 months

---

# Success Criteria

A user can:

1. Create recurring tasks.
2. Complete recurring tasks.
3. Automatically receive future occurrences.
4. Preserve completion history.
5. Synchronize recurrence data across sources.
6. Receive recurring alarms.
7. Edit or delete a single occurrence or an entire series.

This feature should integrate cleanly with Flow's existing multi-source architecture, BLoC state management, SQLite persistence layer, synchronization engine, and alarm scheduling system.