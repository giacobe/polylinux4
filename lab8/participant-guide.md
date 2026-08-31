---
title: "Shell Redirection and Pipelines"
short_title: "Redirection and Pipelines"
panel_title: "Learning Path"
form_url: "https://forms.office.com/Pages/ResponsePage.aspx?id=RY30fNs9iUOpwcEVUm61LvTNagO6dAdDlZnocMnGFFZUMlRIVVRVWjlFODVVQ01PWEE3R0dEREpPQS4u"

---

# Shell Redirection and Pipelines

Learn to connect commands, redirect input and output, capture errors, and turn
one-time commands into repeatable workflows.

## Starting the exercise

Log in as `root`; no password is required. The root login automatically starts
the lab installer. Confirm your normalized email address carefully. Your email
and the exercise date determine your generated files and answers. The VM opens
Level 1 as soon as it is ready while the remaining levels continue building in
parallel.

At any level:

```sh
cat README.txt
nextlevel
prevlevel
```

Navigation is not gated. You may move between levels at any time.

## Answer format

Each level produces one answer shaped like:

```text
REDIR-L01-0123456789abcdef
```

Submit only the token. Case, punctuation, the two-digit level number, and
leading zeroes matter. Do not include labels such as `ANSWER=` or surrounding
explanatory text.

## Command reference

| Syntax | Meaning |
|---|---|
| `command > file` | Replace a file with standard output |
| `command >> file` | Append standard output to a file |
| `command < file` | Supply a file as standard input |
| `first \| second` | Send the first command's stdout to the second command |
| `command 2> file` | Redirect standard error |
| `command > out 2> err` | Save stdout and stderr separately |
| `command > all 2>&1` | Send stderr to the same destination as stdout |
| `first \| tee copy \| next` | Save and continue an intermediate stream |

Redirections are processed from left to right. Consequently, `> all 2>&1` and
`2>&1 > all` do not have the same effect.

## Level hints

### Level 1

Start the report command and use `>` to save what it prints. Search the saved
report using the complete reference and status in the level instructions.

### Level 2

The first command creates the combined report. The next two commands append to
it. Using `>` for all three would repeatedly discard earlier sections.

### Level 3

The selector expects standard input. Put `< catalog.dat` after the command.

### Level 4

Place `|` between the producer and `grep`. After selecting the right record,
another pipe can send it to `cut`.

### Level 5

Extract only the category field before sorting it. `uniq -c` counts adjacent
equal lines, which is why sorting comes first.

### Level 6

File descriptor 2 is standard error. You can discard ordinary output while
saving diagnostics.

### Level 7

Both redirections belong on the same invocation. Inspect the rejected-record
file for the specified reference.

### Level 8

Redirect stdout first, then point stderr at stdout's current destination. Use
the transaction identifier to connect a CHECK event to its RESULT.

### Level 9

Place `tee audit.txt` after the broad ACTIVE filter and before the narrower
target filter.

### Level 10

Each TODO is one pipeline stage. First keep selected valid records, then select
the named reference, then print its token field. The supplied validator checks
stdout, stderr, and the audit file.

## Troubleshooting

- If a file unexpectedly becomes empty, check whether you used `>` where `>>`
  was required.
- If errors still appear on the terminal, verify that you redirected file
  descriptor 2.
- If `uniq -c` shows repeated groups separately, sort the input first.
- If a merged transcript is incomplete, check the left-to-right order of its
  redirections.
- If a validator reports an incorrect audit, recreate the audit through the
  complete intended pipeline rather than editing it manually.
- Reloading the browser VM discards its current state and regenerates the lab.
