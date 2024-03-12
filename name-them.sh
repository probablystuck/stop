read -p "is the process you wish to add to the kill list running? if not, start it. if it's a terminal process, you can start it in a new window. input yes to continue, input remove-kill to clean up the kill list.
" user_direction

if [ $user_direction = "yes" ]
then
  process_name="r"

  until [ "$process_name" != "r" ]
  do
    read -p "in order to add this process to the hit list, we need to match the process name against a pattern. enter a string to see if your pattern is returned, or hit enter to list all running processes
" pattern

    if [ -z "$pattern" ]; then
      echo "$(ps aux)\n"
    else
      # l option will list process name and pid
      echo "$(ps aux | pgrep -fl ${pattern})\n"
    fi

    echo "this is the output of all current running processes, copy the name of the process you wish to add from the last column of output
"

    read -p "if the pattern is successful in returning the process, reenter the pattern to add it to the list. else hit r to restart search
" process_name
  done

  if [ -e "hit_list.txt" ]
  then
    echo "|$process_name\c" >> hit_list.txt
  else
    echo "$process_name\c" >> hit_list.txt
  fi

  list=$(cat "hit_list.txt")

  echo this is your current hit list: $list
fi