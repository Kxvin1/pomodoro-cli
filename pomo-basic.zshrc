# Pomodoro CLI Timer - Basic Version
#
# DEPENDENCIES REQUIRED:
# 1. Timer CLI: https://github.com/caarlos0/timer
#    Install: go install github.com/caarlos0/timer@latest
#    Or download from: https://github.com/caarlos0/timer/releases
#
# 2. Lolcat (for colorful output):
#    Linux: sudo apt install lolcat
#    macOS: brew install lolcat
#
# 3. Speech Dispatcher (for text-to-speech on Linux):
#    Linux: sudo apt install speech-dispatcher
#    macOS: Uses built-in 'say' command (may need script modification)
#
# INSTALLATION:
# 1. Install dependencies above
# 2. Add to ~/.zshrc: source /path/to/pomo-basic.zshrc
# 3. Reload shell: source ~/.zshrc
#
# USAGE:
# wo  - Start 30-minute work session
# br  - Start 10-minute break session


declare -A pomo_options
pomo_options["work"]="30"
pomo_options["break"]="10"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat

  # Start timer and wait for completion
  if timer ${pomo_options["$val"]}m; then
      # Timer completed successfully - announce completion
      spd-say "'$val' session done"
  fi
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"