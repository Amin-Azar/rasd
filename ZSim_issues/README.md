

- If it compiles but exists when you run without printing the config/inputfile/... error messsages:
	-- it is likely that you have a pointer (i.e. array) that is unallocated and you tried to access on runtime! For example a 2D array that you have only allocated the memory for the first dimension.

- [H] Panic on build/debug/zsim_harness.cpp:123: Child 71398 (idx 0) exit was anomalous, killing simulation
	-- this might be a memory access issue if no message prints.
		--- ` received signal SIGABRT, Aborted` in my case was, instead of using PIN_SAFECPY to copy a memory location to an array, I just assigned a casted value of that location, and then freed that location ...
- [S 0] WARN: [0] ContextChange, reason FATAL_SIGNAL, inSyscall 0
	-- Uninitialized or not connected pointer
	-- Killing the debugger (if attached) way too early before zsim attach it properly!
- ^C[H] Panic on build/debug/zsim_harness.cpp:123: Child 78104 (idx 0) exit was anomalous, killing simulation
	-- This is you who killed the process!!
