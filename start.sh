# #!/bin/bash
set -e

# Colors, Solarized theme from https://github.com/necolas/dotfiles

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM='xterm-256color';
fi;

if tput setaf 1 &> /dev/null; then
  tput sgr0; # reset colors
  bold=$(tput bold);
  reset=$(tput sgr0);
  # Solarized colors, taken from http://git.io/solarized-colors.
  black=$(tput setaf 0);
  blue=$(tput setaf 33);
  cyan=$(tput setaf 37);
  green=$(tput setaf 64);
  orange=$(tput setaf 166);
  purple=$(tput setaf 125);
  red=$(tput setaf 124);
  violet=$(tput setaf 61);
  white=$(tput setaf 15);
  yellow=$(tput setaf 136);
else
  bold='';
  reset="\e[0m";
  black="\e[1;30m";
  blue="\e[1;34m";
  cyan="\e[1;36m";
  green="\e[1;32m";
  orange="\e[1;33m";
  purple="\e[1;35m";
  red="\e[1;31m";
  violet="\e[1;35m";
  white="\e[1;37m";
  yellow="\e[1;33m";
fi;

# Font: Modified Doom + Smushed Slant
echo "${bold}${cyan}______         _            _____         _      _  ${green}                          ${reset}"
echo "${bold}${cyan}| ___ \       | |          |  __ \       | |    | | ${green}    ____             __   ${reset}"
echo "${bold}${cyan}| |_/ / _   _ | |__    ___ | |  \/  ___  | |  __| | ${green}   / __ )____ ______/ /_  ${reset}"
echo "${bold}${cyan}|    / | | | ||  _ \  / _ \| | __  / _ \ | | / _  | ${green}  / __  / __ // ___/ __ \ ${reset}"
echo "${bold}${cyan}| |\ \ | |_| || |_) ||  __/| |_\ \| (_) || || (_| | ${green} / /_/ / /_/ (__  ) / / / ${reset}"
echo "${bold}${cyan}\_| \_| \____||____/  \___| \____/ \___/ |_| \____/ ${green}/_____/\____/____/_/ /_/  ${reset}"
echo "${bold}${cyan}                                                    ${green}                          ${reset}"
echo "${bold}${cyan}....is now installed!                               ${green}                          ${reset}"
echo "\n\n \033[0;32mp.s. Follow us at http://twitter.com/TODO.\033[0m"

# Configure history to work the way we want to.
HISTFILE=~/.rubegoldbash_history
SAVEHIST=0
HISTIGNORE=ls:'cd:cd -:pwd:exit:date:* --help:ls:'
HISTTIMEFORMAT='%T %H:%M:%S$'
HISTSIZE=10000
SAVEHIST=10000
HISTCONTROL=ignorespace:ignoredups:erasedups

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
# Append to the Bash history file, rather than overwriting it
shopt -s histappend;
# Autocorrect typos in path names when using `cd`
shopt -s cdspell;


# Nice prompt from https://github.com/necolas/dotfiles.

# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
  userStyle="${red}";
else
  userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
  hostStyle="${bold}${red}";
else
  hostStyle="${yellow}";
fi;

# Set the terminal title to the current working directory.
PS1="\[\033]0;\w\007\]";
PS1+="\[${bold}\]\n"; # newline
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\] at ";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${white}\] in ";
PS1+="\[${green}\]\w"; # working directory
PS1+="\[${white}\] — ";
PS1+="\[${red}\]What do we do now?";
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;
