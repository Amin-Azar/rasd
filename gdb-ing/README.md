
# this=0x0 
- If you can go inside of a function of the class that object is created from, it's probable that your class is doing nothing (not really initialized- or initilized to sth that gdb don't see..) but you can still use the function.
- The C function, similar to what it is exposed in python, have this "this" filed as it's first argument.  someClass::someFunction (this=0x0, ...).

# tips
- `b someCFileName.cpp:118` to set a break point on line 118 of that file (break)
- `c` continue to next occurence.  (continue)
- `c100` skip 100 times and break then.
- `s` step into the function (step)
- `n` run until the next line (next)
- `u180` run until the line number 180 of this file (until)
- `bt` shows the function call trace of where you are (back trace)
- `up` and `down` to move up and down in the hierarchy you see with `bt`
- The point mark (`.`) is similar to c pointer sign (`->`), so to access the members after the first pointer reference, just use dots (e.g. zinfo->cores[1].l1d)
- Cast base pointers to something meaningful if the object is instantiated from a base class: (e.g. ((MESIBottomCC *)(MESICC *)(((OOOCore *)zinfo->cores[1]).l1d).cc).selfId )
- `p Variable` to see the value of a variable (Print)
- `p &Variable` to see the address of it in memory (Print)
- `x someAddress` to see the content of that address (Examine)
- `p/x x/x` .. shows in hex
- `x/5i $pc-6` shows where is your pc and prints 5 instructions up and down of the break point
