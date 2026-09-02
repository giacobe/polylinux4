---
title: "File Manipulation Lab"
short_title: "FM-Lab"
panel_title: "Learning Path"
form_url: "https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUREw5RUJVWlJCS1VZWTBQWFNMTUVTVUdNVS4u"

---

# START: File Manipulation Lab

In this lab you will practice core Linux file manipulation skills. Each level gives you a small filesystem task, such as creating a file, creating a directory, copying evidence, moving suspicious files, removing incorrect files, and organizing an incident response workspace.

Throughout the lab:

- Read the current level's `README.txt` carefully.
- Use the terminal on the right to inspect the files and complete the task.
- Change only the files and directories required by `README.txt`.
- Run `validate` after completing each filesystem task and submit its printed key through the exercise grading form.
- Use the Quick Reference if you need a reminder for common commands.

**Let's get started!**

## LOGIN: Get on the machine

Wait for the VM on the right to finish booting. Once the login prompt appears, log in.

At the login prompt, type:

```text
root
```

No password is required. Just press **Enter**.

The root login automatically starts the installer. Enter your email address and
confirm the normalized address. The VM displays your exercise code and opens
Level 1 as soon as it is ready while the remaining levels continue building in
parallel.

## REF: Quick reference

| Task | Command |
| --- | --- |
| Show where you are | `pwd` |
| List files and directories | `ls` |
| List details, including permissions and owner | `ls -l` |
| List hidden files too | `ls -la` |
| Return to the current level's home directory | `cd` |
| Change into a directory | `cd <directory>` |
| Move back up one directory | `cd ..` |
| Display a text file | `cat <filename>` |
| Create an empty file | `touch <filename>` |
| Create a directory | `mkdir <directory>` |
| Create nested directories | `mkdir -p <path>` |
| Copy a file | `cp <source> <destination>` |
| Move or rename a file or directory | `mv <source> <destination>` |
| Remove a file | `rm <filename>` |
| Remove an empty directory | `rmdir <directory>` |
| Print your current key | `validate` |
| Change to the next level | `nextlevel` |
| Change to the previous level | `prevlevel` |

Replace every angle-bracket placeholder with the actual name or path. Do not type the angle brackets literally.

## INST: Working through a level

Each level starts in its own home directory, `/home/fmlabN`, where `N` is the level number. Before changing anything, return home, confirm your location, and read `README.txt`:

```bash
cd
pwd
cat README.txt
```

Then inspect the files and directories around you:

```bash
pwd
ls
ls -l
```

After the filesystem matches every requirement in `README.txt`, run:

```bash
validate
```

After recording your key, move on when you are ready:

```bash
nextlevel
```

## INST: Validation

The `validate` command always examines the current level user's entire home directory, regardless of your current working directory. It prints a key but does not display a correct or incorrect status.

The key is generated from a cleaned recursive file listing built with common shell tools. Full displayed paths, including ordinary spaces in filenames, sizes, permissions, owner, group, and directory structure affect the key. Dates and times are ignored. File contents are not hashed directly, but a content change that changes a file's size changes the key.

Extra files, missing files, renamed files, permission changes, ownership changes, and changes to `README.txt` produce a different key. Change only what the level requires. Submit the exact 10-character, case-sensitive key printed by `validate` to the exercise grading form. The VM does not know whether a key is correct.

## 1: Level 1

### Goal

Create the required summary file inside the `evidence` directory.

### Skills practiced

- Creating files
- Understanding relative paths
- Using `touch`

### Suggested approach

Start by listing the level files and reading `README.txt`:

```bash
ls
cat README.txt
```

Look inside `evidence`, then create the required empty file at:

```text
evidence/<summary-name-from-README>
```

Do not create the file at the top level of your home directory, and leave the existing reference notes unchanged.

### What to submit

Run `validate` and submit its exact 10-character key to the exercise grading form.

### Continue to the next level

Enter the command `nextlevel`.

## 2: Level 2

### Goal

Add the missing case directory to the `workspace` directory.

### Skills practiced

- Creating directories
- Reading generated target names
- Using `mkdir`

### Suggested approach

Inspect `workspace` and compare its case directories with the required case directory named in `README.txt`.

```bash
ls
ls workspace
```

Create exactly this directory:

```text
workspace/<case-directory-from-README>
```

Do not add, remove, or rename any other case directory. Then validate.

### What to submit

Run `validate` and submit its exact 10-character key to the exercise grading form.

### Continue to the next level

Enter the command `nextlevel`.

## 3: Level 3

### Goal

Copy the selected log to the required backup filename while keeping the original log file.

### Skills practiced

- Copying files
- Preserving original evidence
- Using `cp`

### Suggested approach

Inspect `evidence` and identify the source log and backup filename listed in `README.txt`.

```bash
ls
ls evidence
```

The source log is already in `evidence`. Copy it to the exact backup filename given in `README.txt`, also inside `evidence`:

```text
evidence/<selected-log>
evidence/<backup-filename>
```

The two files must match, and the original log must remain unchanged. Then validate.

### What to submit

Run `validate` and submit its exact 10-character key to the exercise grading form.

### Continue to the next level

Enter the command `nextlevel`.

## 4: Level 4

### Goal

Quarantine the suspicious file while leaving normal downloads in place.

### Skills practiced

- Moving files
- Separating suspicious files from normal files
- Using `mv`

### Suggested approach

Inspect the downloads and quarantine directories.

```bash
ls
ls downloads
ls quarantine
```

Move only the suspicious file named in `README.txt`, preserving its filename:

```text
downloads/<suspicious-file>
-> quarantine/<suspicious-file>
```

The suspicious file must no longer remain in `downloads`. Leave every normal download in place, then validate.

### What to submit

Run `validate` and submit its exact 10-character key to the exercise grading form.

### Continue to the next level

Enter the command `nextlevel`.

## 5: Level 5

### Goal

Remove the file that does not belong in the generated category directory.

### Skills practiced

- Recognizing out-of-place files
- Removing files carefully
- Using `rm`

### Suggested approach

List the files in the category directory named in `README.txt`.

```bash
ls
ls <category-directory>
```

The incorrect filename is not stated directly. Infer it by comparing the filenames with the named category. Remove only the single file that does not fit. Leave the category directory and every matching file intact, then validate.

### What to submit

Run `validate` and submit its exact 10-character key to the exercise grading form.

### Continue to the next level

Enter the command `nextlevel`.

## 6: Level 6

### Goal

Remove the empty old case directory while preserving active case directories and their notes.

### Skills practiced

- Removing empty directories
- Distinguishing active and inactive cases
- Using `rmdir`

### Suggested approach

Inspect `cases` and identify the old case directory named in `README.txt`.

```bash
ls
ls cases
```

Remove exactly the empty directory:

```text
cases/<old-case-directory-from-README>
```

Use `rmdir`. Leave every active case directory and its `notes.txt` file unchanged, then validate.

### What to submit

Run `validate` and submit its exact 10-character key to the exercise grading form.

### Continue to the next level

Enter the command `nextlevel`.

## 7: Level 7

### Goal

Create the selected backup directory and place a preserved copy of the selected log inside it.

### Skills practiced

- Creating directories
- Copying files into a backup directory
- Combining `mkdir` and `cp`

### Suggested approach

Inspect `evidence` and identify the selected log and backup directory named in `README.txt`.

```bash
ls
ls evidence
```

Create the backup directory directly in your level home, not inside `evidence`, and copy the selected log into it:

```text
evidence/<selected-log>
<backup-directory>/<selected-log>
```

Keep the original log unchanged in `evidence`, then validate.

### What to submit

Run `validate` and submit its exact 10-character key to the exercise grading form.

### Continue to the next level

Enter the command `nextlevel`.

## 8: Level 8

### Goal

Move the selected user log into the named archive directory.

### Skills practiced

- Creating an archive directory
- Moving files into an archive directory
- Combining `mkdir` and `mv`

### Suggested approach

Inspect the user logs in your home directory and identify the selected log and archive directory named in `README.txt`.

```bash
ls
```

Create the archive directory directly in your level home, then move the selected log into it:

```text
<archive-directory>/<selected-user-log>
```

The selected log must no longer remain at the top level of your home directory. Leave every other user log unchanged, then validate.

### What to submit

Run `validate` and submit its exact 10-character key to the exercise grading form.

### Continue to the next level

Enter the command `nextlevel`.

## 9: Level 9

### Goal

Build the requested investigation structure and preserve a backup copy of the selected notes file.

### Skills practiced

- Creating nested directories
- Copying notes into a backup directory
- Combining `mkdir` and `cp`

### Suggested approach

Read the investigation structure and notes filename from `README.txt`, then inspect the current files.

```bash
ls
ls templates
cat <notes-filename-from-README>
```

Create this structure directly in your level home, using the personalized names from `README.txt`:

```text
<investigation-root>/
|-- <evidence-directory>/
`-- <backup-directory>/
    `-- <notes-file>
```

Copy the notes file into the backup directory. Keep the original notes file in your level home, and leave `templates` and all template files unchanged. Then validate.

### What to submit

Run `validate` and submit its exact 10-character key to the exercise grading form.

### Continue to the next level

Enter the command `nextlevel`.

## 10: Level 10

### Goal

Complete the incident response workflow.

### Skills practiced

- Creating directories
- Copying evidence
- Moving and quarantining logs
- Removing unrelated files
- Removing an empty directory
- Creating a completion marker file
- Combining `mkdir`, `cp`, `mv`, `rm`, `rmdir`, and `touch`

### Suggested approach

Inspect `incident` and read `README.txt` carefully.

```bash
ls
ls incident
```

Complete every requirement below using the personalized names in `README.txt`:

- Inside `incident`, create the named backup directory.
- Copy the selected service log into that backup directory, keeping the original service log in `incident`.
- Inside `incident`, create the named quarantine directory.
- Move the selected user log into the quarantine directory without renaming it. It must no longer remain directly in `incident`.
- Remove only the named unrelated file.
- Remove only the named empty review directory, using `rmdir`.
- Create the named empty completion marker directly in `incident`.
- Leave every other incident file unchanged.

### What to submit

Run `validate` only after completing every requirement, then submit its exact 10-character key to the exercise grading form.

### End of lab

After you finish level 10 and record your key, you have completed the File Manipulation Lab. Running `nextlevel` from level 10 is not required; it will report that you are already at the final level.
