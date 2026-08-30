---
title: "Polylinux Text Manipulation Lab"
short_title: "Text-Manipulation"
panel_title: "Learning Path"
form_url: "https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUMEk0STYyNzhCMVpEODdMV1E2SDBSSUFHNi4u"

---

# START: Polylinux Text Manipulation Lab

In this lab you will learn essential Linux command-line skills. This lab aims to help you figure out how exactly certain commands work, namely those that involve text manipulation
Throughout the lab:

- Read each step carefully.
- Use the terminal on the right to complete tasks.
- Refer to the Quick Reference if you need help.

**Let's get started!**

## LOGIN: Get On the Machine

Wait for the VM on the right to finish booting. Once the login prompt appears, log in.

At the login prompt, type:

```text
root
```

No password is required. Just press **Enter**.

## REF: Quick Reference

| Task | Command |
| --- | --- |
| Show where you are | `pwd` |
| List files | `ls` |
| Move down into a directory | `cd /[ path ]` |
| Move back up one directory | `cd ..` |
| Display a file | `cat [ filename ]` |
| --- | --- |
| Remove adjacent duplicate lines | `uniq [ filename ]` |
| --- | --- |
| Show the first 10 lines of a file | `head [ filename ]` |
| Show the first 'x' lines of a file | `head -n [ x ] [ filename ]` |
| --- | --- |
| Show the last 10 lines of a file | `tail [ filename ]` |
| Show the last 'x' lines of a file | `head -n [ x ] [ filename ]` |
| --- | --- |
| organize the contents of a file alphabetically | `sort [ filename ]` |
| --- | --- |
| translate a file using a key | `tr [ original elements ] [ translated elements ]` |
| --- | --- |
| find instances of a specific word in a file | `grep [ filter word ] [ file name ]` |
| --- | --- |
| Search for a file by name | `find . -name 'filename' -type f` |
| --- | --- |
| Change to the next level | `nextlevel` |
| Change to the previous level | `prevlevel` |


## INST: Instructions: Explore the File System

Start by seeing where you are and what is around you.

Run these commands:

```bash
pwd
ls
```

What do you notice about the directories and files?

> **Hint:** If a file is long, try `less filename` so you can scroll through it.

## 1: Level 1

### Goal

Translate the word located in the my_psswd file, using the key found in key.txt

### Steps

Start in the level directory:

```bash
ls
cat key.txt
cat my_psswd
cat my_psswd | tr 1356780@# iesgtboah
```

### What to submit

Submit the word you got from translating the my_psswd file.

### Go on to the next level

Enter the command `nextlevel`

## 2: Level 2

### Goal

Find the code that has been buried under a fillerword

### Steps

Start in the level directory:

```bash
ls
cat my_psswd
uniq my_psswd
```

### What to submit

The unique code inside of the my_psswd file.

### Go on to the next level

Enter the command `nextlevel`

## 3: Level 3

### Goal

Use the grep command to find the correct code by filtering by the word 'millionth'.

### Steps

Start in the level directory:

```bash
ls
```

```bash
grep millionth my_psswd
```

### What to submit

Submit the code that is next to the word 'millionth'

### Go on to the next level

Enter the command `nextlevel`

## 4: Level 4

### Goal

Find the code hidden near the beginning of the my_psswd file.

### Steps

Start in the level directory:

```bash
ls
head -n 20 my_psswd
```

### What to submit

The unique code near the top of the my_psswd file

### Go on to the next level

Enter the command `nextlevel`

## 5: Level 5

### Goal

Find the unique code that will be the last possible option alphabetically.

### Steps

Start in the level directory:

```bash
ls
sort my_psswd

```

### What to submit

Submit the special code found at the bottom of the sorted my_psswd file

### Go on to the next level

Enter the command `nextlevel`

## 6: Level 6

### Goal

Use the sort and uniq commands together to find the right code

### Steps

Start in the level directory:

```bash
ls
sort my_psswd | uniq
```

### What to submit

Submit the code that follows the term "Rightcode"

### Go on to the next level

Enter the command `nextlevel`

## 7: Level 7

### Goal

The goal is buried in repeating words, and is also encrypyted, use the uniq and tr functions to find it.

### Steps

Start in the level directory:

```bash
ls
uniq my_psswd | tr GgHhIiJjKkLlMmNnOoPpQqRrSs abcdefghijklmnopqrstuvwxyz
```

### What to submit

Submit the code that follows the term "rightcode"

### Go on to the next level

Enter the command `nextlevel`

## 8: Level 8

### Goal

The code is hidden within the file, and you need to use sort, uniq, and head to bring it to the top of the list.

### Steps

Start in the level directory:

```bash
ls
sort my_psswd | uniq | head
```

### What to submit

Submit the code that follows the term "rightcode"

### Go on to the next level

Enter the command `nextlevel`

## 9: Level 9

### Goal

The code is hidden deep within the file, you need to use grep, uniq -u, and sort to find the code.

### Steps

Start in the level directory:

```bash
ls
grep COMPLETED my_psswd | sort | uniq -u
```

### What to submit

The code that follows the word millionth that you find.

### Go on to the next level

Enter the command `nextlevel`

## 10: Level 10

### Goal

The code is hidden within the my_psswd file, you need to sort the file, use uniq to remove duplicate options, and translate them

### Steps

Start in the level directory:

```bash
ls
sort my_psswd | uniq | tr GgHhIiJjKkLlMmNnOoPpQqRrSs abcdefghijklmnopqrstuvwxyz
```

### What to submit

Submit the code that is next to "rightcode"

### Go on to the next level

Enter the command `nextlevel`

## 11: Level 11

### Goal

The code is hidden deep within a large file, as well as translated. You need to use grep, sort, uniq -u, and tr to get it.

### Steps

Start in the level directory:

```bash
ls
cat my_psswd | tr GgHhIiJjKkLlMmNnOoPpQqRrSs abcdefghijklmnopqrstuvwxyz | grep completed | sort | uniq -u
```
You can also ignore cat, and do tr last, but you cannot use completed as the search term for grep

### What to submit

The code that is found after the word "millionth"
