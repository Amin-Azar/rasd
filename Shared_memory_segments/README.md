

# Query:

> ipcs -l

or for the memory only:
> ipcs -lm

```
   ------ Shared Memory Limits --------
   max number of segments = 4096               // SHMMNI	
   max seg size (kbytes) = 32768               // SHMMAX
   max total shared memory (kbytes) = 8388608  // SHMALL
   min seg size (bytes) = 1
```

# CHANGE KERNEL PARAMETERS:

> vim /etc/sysctl.conf

Your edits here:

```
# ZSims configurations
kernel.shmmax=18014398509465599
kernel.yama.ptrace_scope=0
kernel.shmall=18014398509465599

```

> sysctl -p

