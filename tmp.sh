#!/bin/bash

exec 3>debug.log     # Open file descriptor 3 for writing to the file 'debug.log'

exec 1> >(tee -a debug.log >&3)  # Redirect standard output to file descriptor 3 and display it on the terminal
exec 2> >(tee -a debug.log >&3)  # Redirect standard error to file descriptor 3 and display it on the terminal

echo "This is a test."   # This command will be executed with both stdout and stderr redirected to file descriptor 3 and displayed on the terminal

exec 1>&-            # Close standard output
exec 2>&-            # Close standard error

exec 3>&-            # Close file descriptor 3
