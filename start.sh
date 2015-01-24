# ______         _            _____         _      _
# | ___ \       | |          |  __ \       | |    | |    ____             __
# | |_/ / _   _ | |__    ___ | |  \/  ___  | |  __| |   / __ )____ ______/ /_
# |    / | | | ||  _ \  / _ \| | __  / _ \ | | / _  |  / __  / __ // ___/ __ \
# | |\ \ | |_| || |_) ||  __/| |_\ \| (_) || || (_| | / /_/ / /_/ (__  ) / / /
# \_| \_| \____||____/  \___| \____/ \___/ |_| \____//_____/\____/____/_/ /_/
# https://github.com/ThibWeb/rubegoldbash
# By: Thibaud Colas, License: CC0


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

rubehappy="${yellow}(◕‿◕)";
rubeeager="${yellow}(っ◕‿◕)っ";
rubeimpatient="${yellow}(づ◕‿◕｡)づ";
rubethinking="${yellow}(◕‿◕｡)";
rubeyay="${yellow}(ﾉ◕ヮ◕)ﾉ";
rubepoker="${yellow}༼ つ ◕_◕ ༽つ";
rubewink="${yellow}◕‿↼";

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
# rm -f ~/.rubegoldbash_history
HISTFILE=~/.rubegoldbash_history
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
PS1+="\[${white}\] playing ";
PS1+="\[${cyan}RubeGold\]\[${green}Bash\]"; # host
PS1+="\[${white}\] in ";
PS1+="\[${green}\]\w"; # working directory
PS1+="\[${white}\] — ";
PS1+="\[${rubethinking}\]";
PS1+="\[${red}\] What do we do now?";
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;

# Share your results online!
function share() {
  # history -c; history -r

  # curl ifconfig.me/host
  # curl ifconfig.me/ip

  # TODO unstub

  # TODO Add some player comment? / Player name
  local description="$(whoami)'s RubeGoldBash game — $(date)"
  # , on a $OSTYPE $HOSTTYPE called $HOSTNAME
  echo ""
  echo "${rubeyay} ${white}Yeah!"
  echo "${white}...Uploading ${bold}${userStyle}$(whoami)${white}'s ${cyan}RubeGold${green}Bash ${white}game — ${orange}$(date)${reset}"
  # local gist_response=$(curl -X POST -d "{\"public\":true,\"description\":\"$description\",\"files\":{\"test.txt\":{\"content\":\"test\"}}}" https://api.github.com/gists)
  local gist_response='{"html_url": "https://gist.github.com/banana","test":true}'
  local gist_url=$(echo $gist_response | python -m json.tool | grep '"html_url": "https://gist.github.com/.*",' | cut -d '"' -f 4)

  local voice=$([ $[ $RANDOM % 2 ] == 0 ] && echo "Victoria" || echo "Alex")
  say -v $voice "Yeah!"

  echo ""
  echo "${bold}${yellow}" '____________________________________________________________' "${reset}"
  echo "${bold}${red}"    ' _  _   _          _        ___                             ' "${reset}"
  echo "${bold}${red}"    '| || | (_)  __ _  | |_     / __|  __   ___   _ _   ___   ___' "${reset}"
  echo "${bold}${red}"    '| __ | | | / _` | | ` \    \__ \ / _| / _ \ | `_| / -_) (_-<' "${reset}"
  echo "${bold}${red}"    '|_||_| |_| \__, | |_||_|   |___/ \__| \___/ |_|   \___| /__/' "${reset}"
  echo "${bold}${red}"    '           |___/                                            ' "${reset}"
  echo "${bold}${yellow}" '____________________________________________________________' "${reset}"
  echo ""
  curl --silent http://highscore.rubegoldbash.com/scores.txt | column -s, -t
  echo "${rubeimpatient}${reset}"
  echo ""
  echo "${bold}${white}View the full list online at ${red}http://www.rubegoldbash.com/${reset}"
  echo "${bold}${white}View your saved game at ${bold}${red}$gist_url${reset}"
  echo "${bold}${white}...Want a little extra? Try some \$ ${reset}telnet towel.blinkenlights.nl ${bold}${rubewink} ${white}(to escape, hit ${red}^]${white} and type ${red}quit${white})${reset}"

  say -v $voice "Congratulations"
}
