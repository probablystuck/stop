read -p "is the process you wish to add to the kill list running? if not, start it. if it's a terminal process, you can start it in a new window. input yes to continue, input remove-kill to clean up the kill list.
" user_direction

if [ $user_direction = "yes" ]
then
  read -p "would you like to match the output of running processes against a pattern? enter it below or hit enter to continue
" pattern

  if [ -z "$pattern" ]; then
    echo "$(ps aux)\n"
  else
    echo "$(ps aux | pgrep -fl ${pattern})\n"
  fi

  echo "this is the output of all current running processes, get the name of the process you wish to add from the last column of output\n"
fi

# get processes and their info
# match yarn.js or ocaml, pgrep is specifically designed to search by process name and return pid
# npm run dev gets svelte
# when you ctrl + c a yarn start, start.js goes with it. we need to include that here
pids=($(ps aux | pgrep -f 'yarn.js|start.js|ocaml|npm run dev'))

length=${#pids[@]}

for ((i = 0; i < length; i++))
do
  # outright killing a process is ungraceful, could lead to weirdness and stuff left behind not cleaned up
  # -15 makes it softer
    kill -15 ${pids[i]}
done

# we need this to be set up as a cron job
# this command opens up a cron job editor: crontab -e
# in there, the path to this script is prefixed with 0 * * * *
# this means it'll run every hour