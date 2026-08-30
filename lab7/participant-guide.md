---
title: "PolyLinux Processes"
short_title: "Processes"
panel_title: "Learning Path"
form_url: ""

---

# PolyLinux Processes and Job Control

In this lab you will inspect and manage live Linux processes. Each level
creates a private group of disposable exercise processes owned by the current
`levelN` account. You will identify processes, send signals, manage shell jobs,
change scheduling priority, interpret parent-child relationships, work with
process groups, and resolve a zombie process.

Your process names, roles, tokens, filenames, process trees, and required
values are generated from your learner information. Another student may
receive a different scenario. PIDs are assigned by Linux when a level starts
and will change whenever the level is reset.

## Get on the Machine

Wait for the virtual machine to finish booting. At the login prompt, enter:

```text
root
```

No password is required. Press **Enter**.

If prompted, enter and confirm your email address. Setup uses your email
address and the exercise date to personalize the levels. After installation,
you will enter `level1` automatically.

## Start a Level

Read the generated briefing before doing anything:

```sh
cat README.txt
```

Then launch the level:

```sh
startlevel
```

Inspect the resulting processes:

```sh
levelstatus
ps -o pid,ppid,pgid,stat,comm,args
```

Run `startlevel` again if you need to reset the current level. Resetting stops
the old exercise processes and creates new ones, so all previous PIDs become
invalid.

When you believe the requested state is complete, run:

```sh
the external answer form
```

Level 1 is the exception: it requires an answer argument described in its
briefing.

After `the external answer form` reports completion, capture the live process state:

```sh
submit
```

For Level 1, supply the same quoted PID, PPID, and state assertion:

```sh
submit 'PID|PPID|STATE'
```

The command prints and saves `submission-levelN.txt`. Its SHA-256 covers the
learner identity, exercise date, launch identifier, process rows, states,
priority values, and relevant runtime events.

## Safety Rules

- Act only on processes created for the current exercise level.
- Preserve every process that the briefing identifies as a peer, sibling,
  protected branch, protected group, or protected worker.
- Prefer normal termination before force.
- Do not use broad commands such as `killall sh`, `pkill process-helper`, or a
  signal aimed at every process owned by the account.
- Never signal PID 1 or unrelated operating-system processes.
- Recheck the process table after every important action.
- Use `startlevel` instead of trying to repair a badly damaged scenario.

## Process Terminology

Every process has several useful identifiers:

| Field | Meaning |
|---|---|
| PID | Unique process identifier assigned for the current lifetime |
| PPID | PID of the process that created this process |
| PGID | Process-group identifier shared by related processes |
| STAT | Current process state |
| COMM | Short process name |
| ARGS | Full command and its arguments |

Display those fields with:

```sh
ps -o pid,ppid,pgid,stat,comm,args
```

Common state letters in this lab are:

| State | Meaning |
|---|---|
| `R` | Running or ready to run |
| `S` | Sleeping while waiting for work or a timer |
| `T` | Stopped by job control or a stop signal |
| `Z` | Zombie: exited, but not yet reaped by its parent |

The `STAT` field can contain additional characters. For this lab, the first
letter is the important state.

## Processes and Shell Jobs Are Different

A process is a running program known to the kernel and identified by a PID. A
job is the interactive shell's record of a command or pipeline started from
that shell.

Inspect processes with:

```sh
ps -o pid,ppid,pgid,stat,comm,args
```

Inspect jobs belonging to the current shell with:

```sh
jobs
jobs -l
```

Job notation uses a percent sign:

```text
%1
%2
```

PID notation uses an ordinary number:

```text
731
842
```

Do not put `%` before a PID.

## Signal Quick Reference

Signals ask a process to change state or terminate.

| Purpose | Command |
|---|---|
| Normal termination | `kill PID` |
| Explicit normal termination | `kill -TERM PID` |
| Interrupt | `kill -INT PID` |
| Hangup | `kill -HUP PID` |
| Stop unconditionally | `kill -STOP PID` |
| Continue a stopped process | `kill -CONT PID` |
| Force termination | `kill -KILL PID` |
| List known signals | `kill -l` |

`kill PID` sends `TERM` by default. `TERM` allows a process to perform cleanup.
`KILL` cannot be caught or ignored, so use it only when the briefing calls for
escalation and the requested ordinary signal has failed.

After signaling a process, verify the result:

```sh
ps -o pid,ppid,pgid,stat,comm,args
```

## Job-Control Quick Reference

| Task | Command or key |
|---|---|
| List jobs | `jobs` |
| List jobs with PIDs | `jobs -l` |
| Suspend the foreground job | **Ctrl-Z** |
| Continue job 1 in background | `bg %1` |
| Bring job 1 to foreground | `fg %1` |
| Stop a background job | `kill -STOP %1` |
| Continue a stopped job | `kill -CONT %1` |

**Ctrl-C** interrupts the foreground job. **Ctrl-Z** stops it without
terminating it. Do not confuse these keys.

## Priority Quick Reference

Linux represents user-adjustable scheduling priority with a nice value.
Larger nice values mean the process is more considerate of other work and
generally receives less CPU preference.

Use `top` to observe CPU activity and the `NI` column:

```sh
top
```

Press `q` to leave `top`.

Change a running process to the value assigned by the briefing:

```sh
renice VALUE -p PID
```

For example:

```sh
renice 12 -p 731
```

This image provides procps-ng `ps`, including the `ni` column and `-p`
selection used by the level checker and submission snapshot.

## General Workflow

At every level:

1. Read `README.txt`.
2. Run `startlevel`.
3. Inspect all relevant processes before acting.
4. Write down any temporary PID, PPID, or PGID needed for the live action.
5. Perform the narrowest requested action.
6. Inspect the process table again.
7. Run `the external answer form`.
8. When it passes, run `submit` to create the hashed live-state report.

The VM does not generate a report for an incomplete state. Preserve the entire
`submission-levelN.txt` file: the final SHA-256 protects the exact preceding
blob.

Move between levels with:

```sh
nextlevel
prevlevel
```

Changing levels automatically cleans up the current level's processes.

## Level 1: Process Roll Call

### Goal

Find one assigned process among several distractors and report its live PID,
parent PID, and state.

### Start

```sh
cat README.txt
startlevel
ps -o pid,ppid,pgid,stat,comm,args
```

The briefing gives you a role and a token. Both appear in the target's command
arguments. Search the process listing carefully; do not assume the lowest or
highest PID is the target.

You may filter the listing:

```sh
ps -o pid,ppid,pgid,stat,comm,args | grep 'ROLE'
```

Replace `ROLE` with the generated role from `README.txt`.

### Check

Submit the fields in this exact order:

```sh
the external answer form 'PID|PPID|STATE'
```

Use only the first letter from `STAT`. The quotation marks protect the pipe
characters from being interpreted by the shell.

## Level 2: Graceful Shutdown

### Goal

Terminate the assigned worker normally while preserving its peers. The worker
must receive `TERM` so it can write its clean-shutdown receipt.

### Investigate

```sh
cat README.txt
startlevel
ps -o pid,ppid,pgid,stat,comm,args
```

Match the generated role and token to the correct PID. Then send the default
termination signal:

```sh
kill PID
```

or:

```sh
kill -TERM PID
```

The briefing names the receipt under `runtime/`. You may inspect it after the
worker exits:

```sh
cat runtime/RECEIPT-FILENAME
```

### Check

```sh
the external answer form
```

Force-killing the target will not create a valid graceful-shutdown receipt.

## Level 3: The Stubborn Worker

### Goal

Test the signal named in the briefing, recognize that the target ignored it,
then use the required final signal. Preserve every peer.

### Investigate

```sh
cat README.txt
startlevel
kill -l
ps -o pid,ppid,pgid,stat,comm,args
```

Send the assigned signal:

```sh
kill -SIGNAL PID
```

Wait briefly, then confirm whether the same process remains:

```sh
ps -o pid,ppid,pgid,stat,comm,args
```

If the briefing requires escalation to `KILL`, use:

```sh
kill -KILL PID
```

If it says the required final signal is `TERM`, use `TERM` after testing the
different ignored signal.

### Check

```sh
the external answer form
```

The checker verifies that the assigned ignored signal was actually tested.

## Level 4: Pause and Resume

### Goal

Stop the assigned heartbeat worker, observe that it is stopped, and then
continue it. It must be alive and running when checked.

### Investigate

```sh
cat README.txt
startlevel
ps -o pid,ppid,pgid,stat,comm,args
tail runtime/HEARTBEAT-FILENAME
```

Replace `HEARTBEAT-FILENAME` with the generated name in `README.txt`.

Stop the target:

```sh
kill -STOP PID
```

Confirm its `STAT` begins with `T`. You can also read the heartbeat, wait a few
seconds, and read it again to see that no new entries were added.

Continue it:

```sh
kill -CONT PID
```

Confirm that its state is no longer `T`.

### Check

```sh
the external answer form
```

## Level 5: Foreground and Background Jobs

### Goal

Use the interactive shell's job table. Leave the first named job stopped and
the second named job running in the background.

### Investigate

```sh
cat README.txt
startlevel
jobs -l
```

The job numbers are assigned by the current shell. Match the command names
from the briefing to their `%N` job identifiers.

One way to stop a background job is:

```sh
kill -STOP %N
```

You can also bring a job to the foreground and suspend it:

```sh
fg %N
```

Then press **Ctrl-Z**.

If a job that should run is stopped, resume it in the background:

```sh
bg %N
```

Confirm the requested final states:

```sh
jobs -l
```

### Check

```sh
the external answer form
```

Do not exit the shell between `startlevel` and `the external answer form`; the jobs belong to
that interactive shell.

## Level 6: Control the Resource Hog

### Goal

Identify the process using the most CPU and lower its scheduling priority to
the nice value specified in the briefing. Keep all workers alive.

### Investigate

```sh
cat README.txt
startlevel
top
```

Observe the `%CPU`, `PID`, command, and `NI` columns. The busiest process is
the target even if another process has a more suspicious-looking name. Press
`q` to leave `top`.

Apply the exact generated nice value:

```sh
renice VALUE -p PID
```

Return to `top` if you want to confirm the `NI` value.

### Check

```sh
the external answer form
```

Do not terminate the CPU-heavy worker; the required repair is reprioritization.

## Level 7: Parent, Child, and Branch

### Goal

Map a process tree, terminate every member of one assigned branch, and preserve
the other branch.

### Investigate

```sh
cat README.txt
startlevel
ps -o pid,ppid,pgid,stat,comm,args
```

Begin with the parent role named in the briefing. Use PID and PPID values to
draw the relationships:

```text
parent PID
├── target branch PID
│   ├── child PID
│   └── child PID
└── protected branch PID
    ├── child PID
    └── child PID
```

Terminate the target branch's children and branch process using their specific
PIDs. Recheck the table after signaling. Do not select processes solely by
similar names because the protected branch uses the same overall helper.

### Check

```sh
the external answer form
```

The checker requires the complete target branch to be gone and the complete
protected branch to remain alive.

## Level 8: Pipeline and Process Group

### Goal

Identify the numeric PGID belonging to the assigned group label and send
`TERM` to the entire group as one unit. Preserve the other group.

### Investigate

```sh
cat README.txt
startlevel
ps -o pid,ppid,pgid,stat,comm,args
```

Members with the target group label should share one PGID. Confirm all of them
before signaling.

To signal a process group, pass the negative PGID after `--`:

```sh
kill -TERM -- -PGID
```

For example, if the PGID is `812`:

```sh
kill -TERM -- -812
```

The leading minus sign means “process group 812,” not “PID 812.”

### Check

```sh
the external answer form
```

The target group's members must be gone and every protected-group member must
remain alive.

## Level 9: The Zombie Mystery

### Goal

Identify a zombie, locate its parent, and cause the parent to reap it. Preserve
the parent and its live sibling.

### Investigate

```sh
cat README.txt
startlevel
ps -o pid,ppid,pgid,stat,comm,args
```

Find the generated zombie name and verify that its `STAT` begins with `Z`.
Record its PPID, then locate that parent PID in the same process table.

A zombie has already exited. `KILL`, `TERM`, and other signals cannot make the
zombie exit again. Only its parent can collect its termination status with
`wait`.

Send the control signal specified by the briefing to the parent:

```sh
kill -SIGNAL PARENT_PID
```

Then inspect the table again. The zombie should disappear while the parent and
live sibling remain.

### Check

```sh
the external answer form
```

## Level 10: Process Incident Response

### Goal

Restore a mixed process environment by applying several earlier skills while
preserving the protected worker.

### Start

```sh
cat README.txt
startlevel
ps -o pid,ppid,pgid,stat,comm,args
top
```

Create a small working table before acting:

| Objective | Identity to discover | Required final state |
|---|---|---|
| CPU-heavy worker | PID from `top` | Alive at assigned nice value |
| Paused worker | PID with `T` state | Alive and running |
| Target group | Shared PGID and label | All members terminated by `TERM` |
| Stubborn worker | Role and PID | `TERM` tested, then terminated |
| Protected worker | Role and PID | Still alive |

Complete each requirement deliberately:

```sh
renice VALUE -p CPU_PID
kill -CONT PAUSED_PID
kill -TERM -- -TARGET_PGID
kill -TERM STUBBORN_PID
```

Verify that the stubborn worker ignored `TERM`, then escalate:

```sh
kill -KILL STUBBORN_PID
```

Reinspect the entire process table and confirm that the protected worker still
exists.

### Check

```sh
the external answer form
```

The checker reports the first incomplete objective it finds. Correct it and
run `the external answer form` again.

## Troubleshooting

### `the external answer form` says to run `startlevel`

The current level has no active runtime:

```sh
startlevel
```

### A PID from earlier no longer exists

PIDs change after resets and level changes. Inspect the current process table
again rather than reusing an old number.

### The scenario is damaged

Reset it:

```sh
startlevel
```

Then reread `README.txt`, because the identities remain personalized even
though the PIDs change.

### `ps` rejects `-p` or the `ni` column

That is expected from BusyBox `ps`. Use:

```sh
ps -o pid,ppid,pgid,stat,comm,args
```

Use `top` for CPU usage and nice values.

### A quoted Level 1 answer still fails

Verify the order:

```text
PID|PPID|STATE
```

Use the current PID values and only the first state letter.

### A job is no longer listed by `jobs`

Jobs belong to one interactive shell. If you exited that shell or changed
levels, run `startlevel` again in the current level.

## Finish the Lab

You may revisit any earlier level:

```sh
prevlevel
```

Each level is complete only when `the external answer form` prints:

```text
Level complete.
```

Preserve each `submission-levelN.txt` file for collection or external
verification. The Microsoft 365 intake must be updated to accept the snapshot
blob and digest; the previous short evidence-answer fields are obsolete.
