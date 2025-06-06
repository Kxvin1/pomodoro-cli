# 🍅 Pomodoro CLI Timer

A colorful, feature-rich command-line Pomodoro timer with text-to-speech announcements and auto-cycling capabilities. Perfect for productivity enthusiasts who prefer working in the terminal.

## Screenshots

![Demo](https://i.imgur.com/Ownh25X.gif)

![Pomodoro CLI in action2](https://i.imgur.com/csZMS5H.png)

## ✨ Features

### Basic Version (`pomo-basic.zshrc`)

- ✅ Simple work/break timer functionality
- ✅ Colorful output with `lolcat`
- ✅ Text-to-speech announcements
- ✅ Lightweight and minimal
- ✅ Perfect for users who prefer manual session control

### Enhanced Version (`pomo-with-auto.zshrc`)

- ✅ All basic features plus:
- ✅ **Auto-cycling mode** - continuous work/break cycles
- ✅ **Session tracking** - numbered sessions with progress display
- ✅ **End time calculation** - shows when current session will finish
- ✅ **Enhanced TTS** - different announcements for work/break transitions
- ✅ **Cross-platform TTS** - Linux (espeak/spd-say) + Windows (PowerShell)
- ✅ **Signal handling** - clean exit and session management

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
# Add to your ~/.zshrc file
echo "source $(pwd)/pomo-basic.zshrc" >> ~/.zshrc

# Reload your shell configuration
source ~/.zshrc
```

**For Enhanced Timer:**

```bash
# Add to your ~/.zshrc file
echo "source $(pwd)/pomo-with-auto.zshrc" >> ~/.zshrc

# Reload your shell configuration
source ~/.zshrc
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

### Example Usage Session

```bash
# Start a work session
$ wo
work
⏰ Expected end time: 14:30
Timer: 30m 0s

# After work session completes, take a break
$ br
break
⏰ Expected end time: 14:40
Timer: 10m 0s

# Or use auto-cycling for continuous sessions
$ pc
🔄 Starting auto-cycle pomodoro
💡 Each session runs normally - use Ctrl+C to stop the cycle

--- Session 1 ---
Starting work session...
work
⏰ Expected end time: 14:30
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

- **Shell Compatibility**: Designed specifically for Zsh. May not work properly in Bash or other shells.
- **OS Compatibility**:
  - ✅ Linux (Full support)
  - ✅ macOS (May need TTS modifications)
  - ✅ Windows WSL (Full support)
  - ❌ Windows Command Prompt/PowerShell (Not supported)

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
