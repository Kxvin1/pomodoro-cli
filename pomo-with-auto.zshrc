# Pomodoro CLI Timer - Enhanced Version with Auto-Cycling
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
# 4. Espeak-NG (enhanced speech synthesis):
#    Linux: sudo apt install espeak-ng
#    macOS: brew install espeak
#
# 5. PowerShell (for Windows TTS in WSL):
#    Usually pre-installed on Windows/WSL
#
# INSTALLATION:
# 1. Install all dependencies above
# 2. Add to ~/.zshrc: source /path/to/pomo-with-auto.zshrc
# 3. Reload shell: source ~/.zshrc
#
# USAGE:
# wo  - Start 30-minute work session
# br  - Start 10-minute break session
# pc  - Start auto-cycling mode (continuous work/break cycles)
#
# FEATURES:
# - Auto-cycling between work and break sessions
# - Session numbering and end time display
# - Enhanced TTS announcements
# - Cross-platform compatibility (Linux/macOS/Windows WSL)

declare -A pomo_options
pomo_options["work"]="30"
pomo_options["break"]="10"

# Global variables for enhanced pomodoro functionality
POMO_PAUSED=false
POMO_SKIP=false
POMO_TIMER_PID=""
POMO_AUTO_CYCLE=false
POMO_CURRENT_SESSION=""

# Signal handlers for clean exit and pause/resume
pomo_cleanup() {
    if [[ -n "$POMO_TIMER_PID" ]]; then
        kill $POMO_TIMER_PID 2>/dev/null
    fi
    echo "\n🍅 Pomodoro session interrupted" | lolcat
    POMO_PAUSED=false
    POMO_SKIP=false
    POMO_TIMER_PID=""
    POMO_AUTO_CYCLE=false
    # Kill any background jobs
    jobs -p | xargs -r kill 2>/dev/null
    exit 0
}

pomo_handle_input() {
    # Use a simpler approach that doesn't interfere with job control
    if read -t 0.1 -k 1 key 2>/dev/null; then
        case $key in
            p|P)
                if [[ "$POMO_PAUSED" == "false" ]]; then
                    POMO_PAUSED=true
                    echo "\n⏸️  Session paused. Press 'p' to resume..." | lolcat
                    if [[ -n "$POMO_TIMER_PID" ]]; then
                        kill -STOP $POMO_TIMER_PID 2>/dev/null
                    fi
                else
                    POMO_PAUSED=false
                    echo "\n▶️  Session resumed!" | lolcat
                    if [[ -n "$POMO_TIMER_PID" ]]; then
                        kill -CONT $POMO_TIMER_PID 2>/dev/null
                    fi
                fi
                ;;
            n|N)
                POMO_SKIP=true
                echo "\n⏭️  Skipping current session..." | lolcat
                if [[ -n "$POMO_TIMER_PID" ]]; then
                    kill $POMO_TIMER_PID 2>/dev/null
                fi
                ;;
        esac
    fi
}

# Calculate and display end time
pomo_show_end_time() {
    local duration_minutes=$1
    local end_time=$(date -d "+${duration_minutes} minutes" "+%H:%M")
    echo "⏰ Expected end time: $end_time" | lolcat
}

# Simplified pomodoro function - back to basics
pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
    val=$1

    echo $val | lolcat
    pomo_show_end_time ${pomo_options["$val"]}

    # Start timer and wait for completion
    timer ${pomo_options["$val"]}m

    # Announce completion
    # spd-say "'$val' session done"
    # Next session announcements
    if [[ "$val" == "break" ]]; then
    powershell.exe -Command "Add-Type –AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Initiating next task cycle. Returning to work mode.')"
    elif [[ "$val" == "work" ]]; then
    powershell.exe -Command "Add-Type –AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Work cycle complete. Entering recovery. Please take a break.')"
    fi

  fi
}

# Simple auto-cycle that actually works - no complex input handling
pomo_cycle() {
    echo "🔄 Starting auto-cycle pomodoro" | lolcat
    echo "💡 Each session runs normally - use Ctrl+C to stop the cycle" | lolcat

    # Set up signal handler
    trap 'echo "\n🏁 Auto-cycle stopped" | lolcat; return' INT TERM

    local session_num=1
    while true; do
        echo "\n--- Session $session_num ---" | lolcat

        # Work session
        echo "Starting work session..." | lolcat
        pomodoro "work"

        echo "\n--- Session $((session_num + 1)) ---" | lolcat

        # Break session
        echo "Starting break session..." | lolcat
        pomodoro "break"

        session_num=$((session_num + 2))

        echo "\n🔄 Continuing cycle... (Ctrl+C to stop)" | lolcat
        sleep 3
    done

    trap - INT TERM
}


alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"
alias pc="pomo_cycle"
