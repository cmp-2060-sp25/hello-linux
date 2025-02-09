# hello-linux

Linux is an open-source, Unix-like operating system kernel that serves as the foundation for many operating systems. It was initially created by Linus Torvalds in 1991 and has since evolved into one of the most widely used operating systems worldwide.

## Installing Linux
Since most student have a Windows PC, you can either install linux alongside Windows [dual-boot](https://www.youtube.com/watch?v=eaPVou9lXeU) or install a virtual machine to run linux [virtualbox](https://www.youtube.com/watch?v=Hva8lsV2nTk).

## Working with the Terminal
A shell is a very powerful tool to interact with your computer, where you can read/write files or execute programs. 
In windows, you have `powershell` as such example, in linux one famous example is `bash`.

In a shell you can write commands which can execute a program with some flags and arguments.
```bash
# Executes the date program that prints the system date and time.
date
```
You can also provide arguments to a program
```bash
# Executes the echo program that display a line of text
echo hello-linux
```
It's also possible to provide flags to some program
```bash
# List directory contents in  a long listing formate.
ls -l
```
The shell is able to know about these programs and execute them using the environment variable `$PATH`. To know where some program is located, you can use the `which <program>` command.
```bash
echo $PATH
which echo
# /usr/bin/echo
```
Most programs implement the `--help` flag that provides more info about how to use this program and the options it offers.
You can also use the `man` program for reading the manual of some other program.
```bash
sort --help
man sort
```
Usually we navigate paths using `cd <path>` where the path can either be relative or absolute.
```bash
pwd # print working directory
cd /usr/local/bin # absolute
cd examples/dir1 # relative or use cd ./examples/dir1
cd .. # go to parent dir
cd . # refers to current dir (does nothing)
cd - # go to previous path
cd # go to /home/<user> dir
```
Whenever you modify some file, if it's not created, a new file will be created.
```bash
# modifies a file's timestamp, creates it if it's not created
touch file1.txt 
# Remove a file
rm file1.txt
# Create a new directory
mkdir lab1
# Remove empty dir
rmdir lab1
# Remove a dir with all files inside (recursive rm)
rm -r lab1
# move/rename a file/dir to another location (like cut)
mv file1.txt examples/
mv file1.txt file2.txt
# copy a file
cp file1.txt file3.txt
```
Most programs has an input stream that it reads from and an output stream that it writes to (by default `stdin` and `stdout`). We can change the input stream using `<` and the output stream using `>`.
```bash
# Write hello world to hello.txt
echo "hello world" > hello.txt
# shows contents of file(s)
cat hello.txt
# Write hello to hello.txt, file is completely rewritten
echo "hello" > hello.txt
# Append world to hello.txt
echo "world" >> hello.txt
# same as cat hello.txt
cat < hello.txt 
```
We can wire different programs together (where some program's output is another program's input) using the pipe `|` operator.
```bash
# Output of echo is passed as input to cat which then outputs to the standard output.
echo "Hello world" | cat
# file contents passed to grep which matches against hello
cat hello.txt | grep hello
# same as above, then grep output is passed to another grep program which matches lines ending with d
cat multi_line.txt | grep salam | grep d$
# show my echo command history 
history | grep echo
# show only last line of ls output
ls -l / | tail -n2
```
Reading Writing and Executing files is controlled through file permissions.
```bash
ls -l / | tail -n1
# drwxr-xr-x  12 root root  4096 Aug 27 18:37 usr
# letter 1      -> d which means it's a directory, not a file
# letters 2,3,4 -> owner (root) has read/write/execute permissions
# letters 5,6,7 -> owning group (root) has read/execute permissions
# letters 8,9,10-> everyone else has read/execute permissions
# Notice that nearly all the files in /bin have the x permission set for the last group, “everyone else”, so that anyone can execute those programs
```
To change a file permission we use the `chmod` command
```bash
# Grant user execution permission to file script.sh 
chmod u+x script.sh
```

For safety reasons, some operations are not allowed by normal users, these operations require a `super user` to be done. (ex: modifying the brightness of your screen in `/sys/class/backlight/`)

The `sudo` keyword lets you run a command by the `super user` (`root` user). You can also type `su` in you terminal to change the session user to the `root` user.
```bash
echo 3 > brightness
# bash: brightness: Permission denied
echo 3 | sudo tee brightness
```
## Bash Scripting
Bash is a language where you can have variables, loops, functions and much more.
```bash
# Create a new variable foo with value bar
foo=bar
echo "$foo"
# prints bar
echo '$foo'
# prints $foo
```

For executable files, usually we add a [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) in the first line of the file to let the loader know which interpreter to use to run this file.
```
#!/bin/bash
#!/usr/bin/env python3
```
It is good practice to write shebang lines using the `env` command that will resolve to wherever the command lives in the system, increasing the portability of your scripts.


Arguments can be provided and accessed in a bash script.
- `$0` - Name of the script
- `$1` to `$9` - Arguments to the script. `$1` is the first argument and so on.
- `$@` - All the arguments
- `$#` - Number of arguments
- `$?` - Return code of the previous command
- `$$` - Process identification number (PID) for the current script
- `!!` - Entire last command, including arguments. A common pattern is to execute a command only for it to fail due to missing permissions; you can quickly re-execute the command with sudo by doing `sudo !!`
- `$_` - Last argument from the last command. If you are in an interactive shell, you can also quickly get this value by typing `Esc` followed by `.` or `Alt+.`

Commands will often return output using `STDOUT`, errors through `STDERR`, and a Return Code to report errors in a more script-friendly manner. The return code or exit status is the way scripts/commands have to communicate how execution went. A value of 0 usually means everything went OK; anything different from 0 means an error occurred.

Exit codes can be used to conditionally execute commands using `&&` (and operator) and `||` (or operator), both of which are short-circuiting operators. Commands can also be separated within the same line using a semicolon `;`. The true program will always have a `0` return code and the false command will always have a `1` return code. Let’s see some examples
```bash
false || echo "Oops, fail"
# Oops, fail

true || echo "Will not be printed"
#

true && echo "Things went well"
# Things went well

false && echo "Will not be printed"
#

true ; echo "This will always run"
# This will always run

false ; echo "This will always run"
# This will always run
```
## References
- [The Missing Semester of Your CS Education](https://missing.csail.mit.edu/)
    - First two lectures
- [Hussein Fadl's Playlist](https://www.youtube.com/playlist?list=PLz52v4sWdbUzvTke2yHVM3xmzYrAKDJqf)
    - Bash scripting

