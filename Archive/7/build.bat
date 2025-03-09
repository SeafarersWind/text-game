@echo off
set file=run
if exist %file%.exe (del %file%.exe)
if exist %file%.obj (del %file%.obj)
nasm -f win32 -s %file%.asm -o %file%.obj
if exist %file%.obj (ld %file%.obj -lkernel32 -entry=TheVeryBeginning -subsystem=console -o %file%.exe)
if exist %file%.exe (start %file%.exe)