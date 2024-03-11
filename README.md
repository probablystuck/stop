it bugs me to leave my laptop alone and then see these processes running for days on end simply because I forgot to kill them

near end state:

- prompt user for new ps name
  1. first ask user to ensure that the process is started
     1. "is the process you wish to add to the kill list running? if not, start it. if it's a terminal process, you can start it in a new window. input yes to continue, input remove-kill to clean up the kill list"
  2. "would you like to match the output of running processes against a pattern? enter it below or hit enter to continue"
     1. if enter, list all processes "ps -aux"
     2. else ps aux | pgrep -f '${user_inputed_pattern}'
     3. at the end of output, bolded?
     4. "this is the output of all current running processes, get the name of the process you wish to add from the last column of output"
- "input r to redo search,
  1. r loops again starting at 2
- else input process name to add to list"
  1.  adding to the list means writing the new value to a file that is either created or already existing, | separated
  2.  once added, the list is outputted to the console
  3.  pids variable from the first line in script fills the list of process to pgrep by from the file above
- "would you like to remove items from the kill list? input yes to remove. hit Enter to quit"

- remove-kill
  1. list processes from file
  2. "input process name to remove from kill list"
     1. split? string on process name
     2. append first part of the split with second part of the split with item removed
  3. output new list
  4. "would you like to remove more? input yes to remove more. hit Enter to quit"
     1. loop from 1 again

additional enhancements:

- configure cron job on first use, set a default value. (right now cron will have to be set up separate from this)
- improve above flow to account for the ability to change the amount of time to check for process in cron (set up a new job based on user inputted time series, in addition to the default schedule)
