---
name: gradle-lock-update
description: >
  Use after modifying any .gradle or .gradle.kts file to update Gradle dependency lock files.
  Runs ./gradlew rALA --write-locks with automatic retry on jar-not-found errors.
---

# Gradle Lock Update

## When to use

Use this skill **every time** you modify a `.gradle` or `.gradle.kts` file (adding/removing/changing
dependencies, changing configurations, updating plugins, etc.). Dependency lock files must stay in
sync with the build scripts.

**This is not optional.** If you changed a `.gradle` file and did not run the lock update, the build
will fail for other developers.

## Procedure

Follow these steps **exactly**. Do not skip the retry logic.

### Step 1: Run the lock update

Run from the **repository root** (where `gradlew` lives):

```bash
./gradlew rALA --write-locks
```

### Step 2: Check the result

- **If it succeeds:** Done. Proceed with your next task.
- **If it fails with a "jar not found" error** (or similar artifact-resolution / missing-jar /
  missing-artifact error): go to Step 3.
- **If it fails with a different error:** Diagnose the build error, fix the root cause in the
  `.gradle` file(s), and return to Step 1.

### Step 3: Build jars first, then retry

Run the jar task with lock writing:

```bash
./gradlew jar --write-locks
```

Then re-run the lock update:

```bash
./gradlew rALA --write-locks
```

### Step 4: Verify success

If Step 3 still fails, repeat the cycle (Step 1 -> Step 3) until the lock update completes
successfully. Do **not** move on to other work until the lock files are updated.

If the lock update keeps failing after **3 attempts**, stop and report the full error output to the
developer. Do not keep retrying silently.

## Important notes

- Always run these commands from the **repository root** (where `gradlew` lives).
- Commit the updated lock files together with the `.gradle` changes that caused them.
- Do not manually edit lock files -- they are generated artifacts.
