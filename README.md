# 🍅 Pomodoro CLI Timer

A colorful, feature-rich command-line Pomodoro timer with text-to-speech announcements and auto-cycling capabilities. Perfect for productivity enthusiasts who use the terminal.

This script runs in the background with no input needed once started.

## Preview

![Demo](https://i.imgur.com/wmlZTKK.gif)

![Pomodoro CLI in action2](https://i.imgur.com/Ng3laPO.png)

![Pomodoro CLI in action3](https://i.imgur.com/ilZcAcL.png)

## ✨ Features

### Basic Version (`pomo-basic.zshrc`)

- ✅ Simple work/break timer functionality
- ✅ Colorful output with `lolcat`
- ✅ Text-to-speech announcements
- ✅ Session completion tracking and statistics
- ✅ Motivational summary displays
- ✅ Lightweight and minimal
- ✅ Perfect for users who prefer manual session control

### Enhanced Version (`pomo-with-auto.zshrc`)

- ✅ All basic features plus:
- ✅ **Auto-cycling mode** - continuous work/break cycles
- ✅ **Session tracking** - numbered sessions with progress display
- ✅ **End time calculation** - shows when current session will finish
- ✅ **Enhanced TTS** - different announcements for work/break transitions
- ✅ **Cross-platform TTS** - Linux (espeak/spd-say) + Windows (PowerShell)
- ✅ **Session completion tracking** - tracks completed vs interrupted sessions
- ✅ **Productivity statistics** - historical session counts with motivational messages

## Why Use The Pomodoro Technique?

🧠 **1. Better Focus and Concentration**  
 Working in short, timed intervals (usually 25 minutes) helps you stay locked in on a single task. Knowing there's a break coming reduces mental resistance.

🛌 **2. Reduces Mental Fatigue**  
 Frequent breaks (5 minutes after each session, longer after four) prevent burnout and help your brain reset, especially during long workdays.

🚀 **3. Helps You Start Tasks You’re Avoiding**  
 Committing to "just 25 minutes" feels manageable, making it easier to beat procrastination and overcome task inertia.

⏱️ **4. Tracks Time and Boosts Awareness**  
 Each Pomodoro is a unit of time you can measure. Over time, it helps you understand how long things really take and manage your time more realistically.

🎯 **5. Encourages Single-tasking**  
 It forces you to commit to one task per session, helping you avoid the productivity drain of multitasking.

🏆 **6. Builds a Sense of Accomplishment**  
 Each completed Pomodoro is a small win, giving you a mental reward and momentum to keep going.

⚖️ **7. Improves Work-Life Balance**  
 By structuring your day into focused work blocks and scheduled breaks, it prevents overworking and encourages healthier rhythms.

## 📋 Prerequisites

### Required Tools

1. **Zsh Shell** - This tool is designed for Zsh
2. **Timer CLI** - Core timing functionality
3. **Lolcat** - Colorful text output
4. **Text-to-Speech Engine** - For audio announcements

## 🚀 Installation

### Step 1: Install Dependencies

#### Linux (Ubuntu/Debian)

```bash
# Update package list
sudo apt update

# Install lolcat for colorful output
sudo apt install lolcat

# Install speech dispatcher for text-to-speech
sudo apt install speech-dispatcher

# Install espeak-ng for enhanced speech synthesis
sudo apt install espeak-ng

# Install timer CLI tool
# Option 1: Using Go (if you have Go installed)
go install github.com/caarlos0/timer@latest

# Option 2: Download binary from GitHub releases
wget https://github.com/caarlos0/timer/releases/latest/download/timer_Linux_x86_64.tar.gz
tar -xzf timer_Linux_x86_64.tar.gz
sudo mv timer /usr/local/bin/
```

#### macOS

```bash
# Install Homebrew if you haven't already
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install lolcat
brew install lolcat

# Install timer
brew install caarlos0/tap/timer

# Install espeak for text-to-speech
brew install espeak

# Note: macOS has built-in 'say' command, but the script uses Linux-style commands
```

#### Windows (WSL - Windows Subsystem for Linux)

```bash
# First, ensure you have WSL2 with Ubuntu installed
# Then follow the Linux installation steps above

# Additionally, ensure PowerShell is available (usually pre-installed on Windows)
```

### Step 2: Install the Pomodoro Timer

#### Option 1: Clone the Repository

```bash
git clone https://github.com/Kxvin1/pomodoro-cli.git
cd pomodoro-cli
```

#### Option 2: Download Files Manually

Download `pomo-basic.zshrc` and `pomo-with-auto.zshrc` from the repository.

### Step 3: Choose Your Version

#### Which Version Should You Use?

**Choose Basic Version if you:**

- Prefer manual control over sessions
- Want minimal resource usage
- Like simple, straightforward functionality
- Don't need auto-cycling features

**Choose Enhanced Version if you:**

- Want continuous work/break cycles
- Like detailed session tracking
- Need cross-platform TTS support
- Want advanced timer features

#### Set Up Shell Integration

**For Basic Timer:**

```bash
# If you're using Zsh or Bash, run this to start the timer
source ./pomo-basic.zshrc

# Refer to usage commands below for usage under 'Usage'
```

**For Enhanced Timer:**

```bash
# If you're using Zsh or Bash, run this to start the timer
source ./pomo-with-auto.zshrc

# Refer to usage commands below for usage under 'Usage'
```

**Note**: You can switch between versions anytime by commenting out one source line and uncommenting the other in your `~/.zshrc`.

## 📖 Usage

### Basic Commands

#### Work Session (30 minutes)

```bash
wo
# or
pomodoro work
```

#### Break Session (10 minutes)

```bash
br
# or
pomodoro break
```

#### Auto-Cycling Mode (Enhanced version only)

```bash
pc
# Starts continuous work/break cycles
# Use Ctrl+C to stop
```

#### Session Statistics

```bash
summary
# Shows productivity statistics including:
# - Current session completion count
# - Total historical session count
# - Motivational messages based on progress
```

#### Reset Session History

```bash
reset-pomo
# Resets all session history with confirmation prompt
# Use this to start fresh or clear old data
```

### Example Usage Session

```bash
# Start a work session
$ wo
work
⏰ Expected end time: 14:30
Timer: 30m 0s
✅ Session completed and recorded!

# After work session completes, take a break
$ br
break
⏰ Expected end time: 14:40
Timer: 10m 0s
✅ Session completed and recorded!

# Check your productivity statistics
$ summary
📈 Fetching your productivity statistics...

🍅 ═══════════════════════════════════════════════════════ 🍅
                    POMODORO SUMMARY
🍅 ═══════════════════════════════════════════════════════ 🍅

📊 Current Session: 2 completed
🏆 Total Historical: 15 completed

💪 You're developing excellent focus habits!

💡 Each completed session brings you closer to your goals!
🍅 ═══════════════════════════════════════════════════════ 🍅

# Or use auto-cycling for continuous sessions
$ pc
🔄 Starting auto-cycle pomodoro
💡 Each session runs normally - use Ctrl+C to stop the cycle

--- Session 1 ---
Starting work session...
work
⏰ Expected end time: 14:30
```

## 📊 Session Tracking & Statistics

Both versions now include comprehensive session tracking to help you monitor your productivity progress:

### How Session Tracking Works

- **Completion Detection**: Only sessions that run for their full duration are counted as "completed"
- **Interrupted Sessions**: Sessions stopped early (Ctrl+C) are not counted toward your totals
- **Persistent Storage**: Session counts are stored in `~/.pomo_sessions.dat` and persist across terminal sessions
- **Current vs Historical**: Track both your current session's completions and your all-time total

### Automatic Features

- **Session Confirmation**: Each completed session shows a confirmation message
- **Motivational Messages**: Progress-based encouragement based on your total session count

### Statistics Levels

- **🌱 Beginner** (0 sessions): Ready to start your productivity journey!
- **🚀 Getting Started** (1-4 sessions): Great start! Keep building that focus muscle!
- **💪 Developing** (5-24 sessions): You're developing excellent focus habits!
- **🔥 Champion** (25-99 sessions): Impressive dedication! You're a productivity champion!
- **🏅 Master** (100+ sessions): Legendary focus master! Your discipline is inspiring!

### Data Management

- **Storage Location**: Session data is stored in your home directory: `~/.pomo_sessions.dat`
- **File Format**: Simple text file containing a single number (total completed work sessions)
- **Persistence**: Data survives terminal restarts, system reboots, and script reloads
- **Current vs Historical**:
  - **Current Session**: Resets each time you start a new terminal session
  - **Historical Total**: Persists forever until manually reset

#### Resetting Your Data

```bash
# Easy way (with confirmation prompt)
reset-pomo

# Manual way (immediate reset)
rm ~/.pomo_sessions.dat

# Or reset to specific number
echo "50" > ~/.pomo_sessions.dat
```

## ⚙️ Configuration

### Default Session Times

- **Work sessions**: 30 minutes
- **Break sessions**: 10 minutes

### Customizing Session Duration

Edit the session times in your chosen `.zshrc` file:

```bash
# Modify these values in pomo-basic.zshrc or pomo-with-auto.zshrc
pomo_options["work"]="25"    # 25 minutes for work
pomo_options["break"]="5"    # 5 minutes for break
```

### Advanced Configuration

#### Disabling Text-to-Speech

If you want to disable TTS announcements, comment out the speech lines:

**In pomo-basic.zshrc:**

```bash
# Comment out this line:
# spd-say "'$val' session done"
```

**In pomo-with-auto.zshrc:**

```bash
# Comment out these lines:
# powershell.exe -Command "Add-Type –AssemblyName System.Speech; ..."
```

#### Adding Custom Session Types

You can add new session types by modifying the `pomo_options` array:

```bash
# Add custom sessions
pomo_options["longbreak"]="15"    # 15-minute long break
pomo_options["focus"]="45"        # 45-minute deep focus session

# Then create aliases
alias lb="pomodoro 'longbreak'"
alias focus="pomodoro 'focus'"
```

## 🧪 Testing Your Installation

After installation, test that everything works correctly:

### 1. Test Dependencies

```bash
# Check if timer is installed
timer --version

# Check if lolcat is installed
echo "test" | lolcat

# Check if speech tools are available (Linux)
spd-say "test" 2>/dev/null || echo "TTS not available"
```

### 2. Test Basic Functionality

```bash
# Test a short work session (1 minute for testing)
# First, temporarily modify the work duration in your .zshrc file:
# pomo_options["work"]="1"

# Then test:
wo

# You should see:
# - Colorful "work" text
# - Expected end time
# - Timer countdown
# - TTS announcement when complete
```

### 3. Test Auto-Cycling (Enhanced version only)

```bash
# Test auto-cycling with short durations
# Modify both work and break to 1 minute for testing
pc

# Use Ctrl+C to stop after testing
```

## 🔧 Troubleshooting

### Common Issues

#### 1. "timer: command not found"

**Solution**: Install the timer CLI tool following the installation steps above.

#### 2. "lolcat: command not found"

**Solution**: Install lolcat using your package manager:

```bash
# Linux
sudo apt install lolcat

# macOS
brew install lolcat
```

#### 3. No text-to-speech announcements

**Linux**: Ensure speech-dispatcher is installed and running:

```bash
sudo apt install speech-dispatcher
systemctl --user start speech-dispatcher
```

**macOS**: The script uses Linux-style TTS commands. You may need to modify the script to use `say` command instead.

**Windows**: Ensure you're running in WSL and PowerShell is accessible.

#### 4. "Bad substitution" or syntax errors

**Solution**: Ensure you're using Zsh shell:

```bash
# Check current shell
echo $SHELL

# Switch to Zsh if needed
chsh -s $(which zsh)
```

#### 5. Auto-cycle stops unexpectedly

**Solution**: This is usually due to shell job control. Use Ctrl+C to properly stop the cycle, then restart if needed.

### Compatibility Notes

- **Shell Compatibility**:
  - ✅ Bash (fully supported – default on most Linux systems, including WSL)
  - ✅ Zsh (fully supported – originally written with Zsh syntax, but Bash-compatible)
  - ⚠️ Other shells (e.g., fish, tcsh): not tested and likely incompatible
- **OS Compatibility**:
  - ✅ Linux (Full support)
  - ✅ macOS (TTS may need slight script tweaks — uses say instead of spd-say or PowerShell)
  - ✅ Windows (WSL) (Full support using PowerShell for TTS)
  - ❌ Windows Command Prompt/PowerShell directly (Not supported — use WSL instead)

## 🎯 Tips for Best Results

1. **Use in a dedicated terminal**: Keep the timer running in its own terminal window
2. **Customize durations**: Adjust work/break times to match your productivity style
3. **Use auto-cycling**: Great for deep work sessions where you don't want to manually restart
4. **Terminal notifications**: The colorful output makes it easy to see session status at a glance

## 🤝 Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

## 📄 License

This project is open source. Please check the repository for license details.

---

**Happy Productivity! 🍅✨**
