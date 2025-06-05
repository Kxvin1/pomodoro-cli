# study stream aliases
# Requires https://github.com/caarlos0/timer to be installed. spd-say should ship with your distro

# Also requires lolcat --> 
# sudo apt update
# sudo apt install lolcat

# and requires spd if you don't have -->
# sudo apt update
# sudo apt install speech-dispatcher


declare -A pomo_options
pomo_options["work"]="30"
pomo_options["break"]="10"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  spd-say "'$val' session done"
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"