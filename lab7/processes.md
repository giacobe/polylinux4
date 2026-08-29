# PolyLinux Processes and Job Control

In this lab you will inspect and manage disposable Linux processes. Every
level creates a private process scenario for the current `levelN` account.

Begin each level with:

```sh
cat README.txt
startlevel
ps -o pid,ppid,pgid,stat,ni,comm,args
```

Useful commands include:

| Task | Command |
|---|---|
| Inspect processes | `ps -o pid,ppid,pgid,stat,ni,comm,args` |
| Watch activity | `top` |
| Send normal termination | `kill PID` |
| Send a named signal | `kill -SIGNAL PID` |
| Signal a process group | `kill -TERM -- -PGID` |
| Inspect shell jobs | `jobs` |
| Resume a job in background | `bg %N` |
| Bring a job forward | `fg %N` |
| Change priority | `renice VALUE -p PID` |
| Reset the case | `startlevel` |
| Check the result | `checklevel` |

Do not use broad commands such as `killall sh`. Each case includes protected
processes, and only processes belonging to the exercise are in scope.

Process state letters used in the lab include:

- `R`: running or runnable
- `S`: sleeping
- `T`: stopped
- `Z`: zombie

PIDs change whenever a level is reset. Identify processes from their role,
token, parent, group, and observed behavior rather than memorizing numbers.
