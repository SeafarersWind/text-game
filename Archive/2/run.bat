@echo off
set file=run
del %file%.exe
del %file%.obj
nasm -f win32 -s %file%.asm -o %file%.obj
golink /entry:Start /console kernel32.dll user32.dll %file%.obj
@echo,--------------------------------------------------------------------------------
@echo,
@echo,
@echo,
%file%.exe
@echo,
pause