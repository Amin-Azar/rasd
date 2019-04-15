
# gdb gives you this=0x0 for an object
- If you can go inside of a function of the class that object is created from, it's probable that your class is doing nothing (not really initialized- or initilized to sth that gdb don't see..) but you can still use the function.
- The C function, similar to what it is exposed in python, have this "this" filed as it's first argument.  someClass::someFunction (this=0x0, ...).
