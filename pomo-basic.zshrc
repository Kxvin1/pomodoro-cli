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
# wo          - Start 30-minute work session
# br          - Start 10-minute break session
# summary     - Show session completion statistics
# reset-pomo  - Reset all session history (with confirmation)


declare -A pomo_options
pomo_options["work"]="30"
pomo_options["break"]="10"

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

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
    val=$1
    echo $val | lolcat

    # Start timer and wait for completion (original approach to preserve TTS)
    timer ${pomo_options["$val"]}m
    local timer_exit_code=$?

    # Timer completed successfully - announce completion with TTS (original logic)
    spd-say "'$val' session done"

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
alias summary="pomo_summary_command"
alias reset-pomo="pomo_reset_command"