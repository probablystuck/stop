# get processes and their info
# match yarn.js or ocaml, pgrep is specifically designed to search by process name and return pid
pids=($(ps aux | pgrep -f 'yarn.js|ocaml'))

# echo $pids

length=${#pids[@]}

# Print the length
echo "Length of list: $length"

for ((i = 0; i < length; i++))
do
    echo "Count: $i"
    echo "${pids[i]}"
    kill -15 ${pids[i]}
done

# we need this to be set up as a cron job
# this command opens up a cron job editor: crontab -e
# in there, the path to this script is prefixed with 0 * * * *
# this means it'll run every hour