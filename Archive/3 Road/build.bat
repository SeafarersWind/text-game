@echo off
set file=run
del %file%.exe
del %file%.obj
nasm -f win32 -s %file%.asm -o %file%.obj
ld %file%.obj -lkernel32 -entry=TheVeryBeginning -subsystem=console -o %file%.exe
start %file%.exe