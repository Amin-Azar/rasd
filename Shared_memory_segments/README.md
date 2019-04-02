

# QUERY

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


# CHECK MEMORY (RAM) SPACE and SWAP
> free

```
             total       used       free     shared    buffers     cached
Mem:      65980220    5338908   60641312          0     391848    3953228
-/+ buffers/cache:     993832   64986388
Swap:       786428          0     786428
```

# CHECK MOUNTING POINT OF SHARED MEMORY

> df -h  

```
Filesystem                  Size  Used Avail Use% Mounted on
/dev/mapper/precise64-root   79G  6.0G   70G   8% /
udev                         32G   12K   32G   1% /dev
tmpfs                        13G  304K   13G   1% /run
none                        5.0M     0  5.0M   0% /run/lock
none                         32G     0   32G   0% /run/shm    <- ************ THIS IS WHERE IT IS MOUNTED => MAX 32GB
/dev/sda1                   228M   50M  167M  23% /boot
vagrant                     785G  222G  564G  29% /vagrant
```

# RESIZE SHARED MEMORY MAX SIZE

> sudo vim /etc/fstab 
add the following to use all of your RAM size:
```
none   /run/shm        tmpfs   defaults,size=100%      0       0 # OR maybe tmpfs
```
Or if it's already booted:
```
mount -o remount,size=100% /run/shm
```
