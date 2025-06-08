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
# wo          - Start 30-minute work session
# br          - Start 10-minute break session
# pc          - Start auto-cycling mode (continuous work/break cycles)
# summary     - Show session completion statistics
# reset-pomo  - Reset all session history (with confirmation)
#
# FEATURES:
# - Auto-cycling between work and break sessions
# - Session numbering and end time display
# - Enhanced TTS announcements
# - Session completion tracking and statistics
# - Motivational summary displays
# - Cross-platform compatibility (Linux/macOS/Windows WSL)

declare -A pomo_options
pomo_options["work"]="1"
pomo_options["break"]="1"

# Session tracking variables
POMO_DATA_FILE="$HOME/.pomo_sessions.dat"
POMO_CURRENT_SESSIONS=0

# Initialize session tracking
pomo_init_tracking() {
    # Create data file if it doesn't exist
    if [[ ! -f "$POMO_DATA_FILE" ]]; then
        echo "0" > "$POMO_DATA_FILE"
    fi
}

# Get total historical sessions
pomo_get_total_sessions() {
    pomo_init_tracking
    cat "$POMO_DATA_FILE" 2>/dev/null || echo "0"
}

# Increment total sessions
pomo_increment_total() {
    local current_total=$(pomo_get_total_sessions)
    local new_total=$((current_total + 1))
    echo "$new_total" > "$POMO_DATA_FILE"
}

# Record a completed session
pomo_record_completion() {
    POMO_CURRENT_SESSIONS=$((POMO_CURRENT_SESSIONS + 1))
    pomo_increment_total
}

# Display session summary
pomo_show_summary() {
    local total_sessions=$(pomo_get_total_sessions)
    local current_sessions=$POMO_CURRENT_SESSIONS

    echo ""
    echo "🍅 ═══════════════════════════════════════════════════════ 🍅" | lolcat
    echo "                    POMODORO SUMMARY                      " | lolcat
    echo "🍅 ═══════════════════════════════════════════════════════ 🍅" | lolcat
    echo ""
    echo "📊 Current Session: $current_sessions work sessions completed" | lolcat
    echo "🏆 Total Historical: $total_sessions work sessions completed" | lolcat
    echo ""

    # Motivational messages based on total sessions
    if [[ $total_sessions -eq 0 ]]; then
        echo "🌱 Ready to start your productivity journey!" | lolcat
    elif [[ $total_sessions -lt 5 ]]; then
        echo "🚀 Great start! Keep building that focus muscle!" | lolcat
    elif [[ $total_sessions -lt 25 ]]; then
        echo "💪 You're developing excellent focus habits!" | lolcat
    elif [[ $total_sessions -lt 100 ]]; then
        echo "🔥 Impressive dedication! You're a productivity champion!" | lolcat
    else
        echo "🏅 Legendary focus master! Your discipline is inspiring!" | lolcat
    fi

    echo ""
    echo "💡 Each completed session brings you closer to your goals!" | lolcat
    echo "🍅 ═══════════════════════════════════════════════════════ 🍅" | lolcat
    echo ""
}

# Exit summary (for current session only)
pomo_show_exit_summary() {
    if [[ $POMO_CURRENT_SESSIONS -gt 0 ]]; then
        echo ""
        echo "🎯 Session Complete! You finished $POMO_CURRENT_SESSIONS work session(s) this run." | lolcat
        echo "✨ Well done! Every completed work session is a step toward mastery." | lolcat
        echo ""
    fi
}

# Calculate and display end time
pomo_show_end_time() {
    local duration_minutes=$1
    local end_time=$(date -d "+${duration_minutes} minutes" "+%I:%M %p")
    echo "⏰ Expected end time: $end_time" | lolcat
}

# Main pomodoro function with enhanced TTS and session tracking
pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
    val=$1

    echo $val | lolcat
    pomo_show_end_time ${pomo_options["$val"]}

    # Start timer and wait for completion (original approach to preserve TTS)
    timer ${pomo_options["$val"]}m
    local timer_exit_code=$?

    # Announce completion with enhanced TTS (original logic)
    if [[ "$val" == "break" ]]; then
        powershell.exe -Command "Add-Type –AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Initiating next task cycle. Returning to work mode.')"
    elif [[ "$val" == "work" ]]; then
        powershell.exe -Command "Add-Type –AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Work cycle complete. Entering recovery. Please take a break.')"
    fi

    # Record session completion after TTS based on exit code (only for work sessions)
    if [[ $timer_exit_code -eq 0 ]]; then
        if [[ "$val" == "work" ]]; then
            pomo_record_completion
            echo "✅ Work session completed and recorded!" | lolcat
        else
            echo "✅ Break completed!" | lolcat
        fi
    else
        if [[ "$val" == "work" ]]; then
            echo "⏸️  Work session interrupted - not counted toward total" | lolcat
        else
            echo "⏸️  Break interrupted" | lolcat
        fi
    fi

  fi
}

# Auto-cycle function for continuous work/break sessions
pomo_cycle() {
    echo "🔄 Starting auto-cycle pomodoro" | lolcat
    echo "💡 Each session runs normally - use Ctrl+C to stop, then 'summary' for stats" | lolcat

    # Set up signal handler with exit summary
    trap 'echo "🏁 Auto-cycle stopped" | lolcat; pomo_show_exit_summary; return' INT TERM

    local session_num=1
    while true; do
        echo "--- Session $session_num ---" | lolcat

        # Work session
        echo "Starting work session..." | lolcat
        pomodoro "work"

        echo "--- Session $((session_num + 1)) ---" | lolcat

        # Break session
        echo "Starting break session..." | lolcat
        pomodoro "break"

        session_num=$((session_num + 2))

        echo "🔄 Continuing cycle... (Ctrl+C to stop, then type 'summary' to see your stats)" | lolcat
        sleep 3
    done

    trap - INT TERM
}


# Summary command function
pomo_summary_command() {
    echo "📈 Fetching your productivity statistics..." | lolcat
    sleep 1
    pomo_show_summary
}

# Reset command function
pomo_reset_command() {
    echo "⚠️  Are you sure you want to reset ALL session history? (y/N)" | lolcat
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo "0" > "$POMO_DATA_FILE"
        POMO_CURRENT_SESSIONS=0
        echo "🗑️  Session history reset! Starting fresh." | lolcat
    else
        echo "❌ Reset cancelled. Your history is safe!" | lolcat
    fi
}

# Initialize tracking on script load
pomo_init_tracking

# Set up global signal handler for exit summary
trap 'pomo_show_exit_summary; exit' INT TERM

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"
alias pc="pomo_cycle"
alias summary="pomo_summary_command"
alias reset-pomo="pomo_reset_command"
