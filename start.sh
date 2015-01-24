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
rubemeh="${yellow}(◕_◕)";
rubeeager="${yellow}(っ◕‿◕)っ";
rubeimpatient="${yellow}(づ◕‿◕｡)づ";
rubethinking="${yellow}(◕‿◕｡)";
rubeyay="${yellow}(ﾉ◕ヮ◕)ﾉ";
rubepoker="${yellow}༼ つ ◕_◕ ༽つ";
rubewink="${yellow}◕‿↼";

# Font: Modified Doom + Smushed Slant
echo "${bold}${yellow}______________________________________________________________________________${reset}"
echo "${bold}${cyan}______         _            _____         _      _  ${green}                          ${reset}"
echo "${bold}${cyan}| ___ \       | |          |  __ \       | |    | | ${green}    ____             __   ${reset}"
echo "${bold}${cyan}| |_/ / _   _ | |__    ___ | |  \/  ___  | |  __| | ${green}   / __ )____ ______/ /_  ${reset}"
echo "${bold}${cyan}|    / | | | ||  _ \  / _ \| | __  / _ \ | | / _  | ${green}  / __  / __ // ___/ __ \ ${reset}"
echo "${bold}${cyan}| |\ \ | |_| || |_) ||  __/| |_\ \| (_) || || (_| | ${green} / /_/ / /_/ (__  ) / / / ${reset}"
echo "${bold}${cyan}\_| \_| \____||____/  \___| \____/ \___/ |_| \____/ ${green}/_____/\____/____/_/ /_/  ${reset}"
echo "${bold}${yellow}______________________________________________________________________________${reset}"
echo "${bold}${cyan}....is now installed! ${rubehappy} Cool, let's get started!${reset}"
echo "${bold}${rubeeager} I'm Rube, the command-line guru. Nice to meet you, ${orange}$(whoami)."
echo "${bold}${rubethinking} Don't you want to type some commands? Let's try some ${white}ls${yellow}, for example."

function calculator() {
  local result="";
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";
  #                       └─ default (when `--mathlib` is used) is 20
  #
  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
    sed -e 's/^\./0./'        # add "0" for cases like ".5"` \
        -e 's/^-\./-0./'      # add "0" for cases like "-.5"`\
        -e 's/0*$//;s/\.$//'; # remove trailing zeros
  else
    printf "$result";
  fi;
  printf "\n";
}

# Calculates the player score!
export BESTSCORE=$(calculator 0)
function score_game() {
  local combo='|'
  history -a
  history -c
  history -r
  local last_command=$(cat $HISTFILE | tail -n 1)
  local multiplier=$(grep -o "$combo" <<< $last_command | wc -l)
  multiplier=$((multiplier))
  local command_length=$(echo $last_command | wc -m)
  local command_score=$(( multiplier * command_length ))

  export BESTSCORE=$(($BESTSCORE > $command_score ? $BESTSCORE: $command_score))

  if [[ "$command_score" -eq 0 ]]; then
    local rubeface=$rubemeh;
  else
    local rubeface=$rubehappy;
  fi;

  echo "${rubeface} Command Score:${white} $command_score${yellow}, Best: ${white}$BESTSCORE"
}

# Configure history to work the way we want to.
export HISTFILE=~/.rubegoldbash_history
history -w
rm -f ~/.rubegoldbash_history
touch ~/.rubegoldbash_history
export HISTIGNORE=''
export HISTTIMEFORMAT='%T $'
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL=ignoreboth:erasedups

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}score_game"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"
# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

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
  history -w

  local voice=$([ $[ $RANDOM % 2 ] == 0 ] && echo "Victoria" || echo "Alex")

  local description="$(whoami)'s RubeGoldBash game — $(date)"

  if [[ "$BESTSCORE" -eq 0 ]]; then
    local rubeface=$rubemeh;
    local message="Try again.";
  else
    local rubeface=$rubehappy;
    local message="Yeah!";
  fi;

  echo ""
  echo "${rubeface} $message You scored ${red}$BESTSCORE points!"
  say -v $voice "$message You scored $BESTSCORE points!"
  echo "${white}...Uploading ${bold}${userStyle}$(whoami)${white}'s ${cyan}RubeGold${green}Bash ${white}game — ${orange}$(date)${reset}"

  local gist_response=$(curl --silent -X POST -d "{\"public\":true,\"description\":\"$description\",\"files\":{\"history.sh\":{\"content\":\"test\"}}}" https://api.github.com/gists)
  # local gist_response='{"html_url": "https://gist.github.com/banana","test":true}'
  local gist_url=$(echo $gist_response | python -m json.tool | grep '"html_url": "https://gist.github.com/.*",' | cut -d '"' -f 4)

  echo ""
  echo "${bold}${yellow}" '____________________________________________________________' "${reset}"
  echo "${bold}${red}"    ' _  _   _          _        ___                             ' "${reset}"
  echo "${bold}${red}"    '| || | (_)  __ _  | |_     / __|  __   ___   _ _   ___   ___' "${reset}"
  echo "${bold}${red}"    '| __ | | | / _` | | ` \    \__ \ / _| / _ \ | `_| / -_) (_-<' "${reset}"
  echo "${bold}${red}"    '|_||_| |_| \__, | |_||_|   |___/ \__| \___/ |_|   \___| /__/' "${reset}"
  echo "${bold}${red}"    '           |___/                                            ' "${reset}"
  echo "${bold}${yellow}" '____________________________________________________________' "${reset}"
  echo ""
  curl --silent -X POST --data "player=$(whoami)&score=$BESTSCORE&gist=test" http://highscore.rubegoldbash.com/scores.txt | column -s, -t
  # curl --silent http://highscore.rubegoldbash.com/scores.txt | column -s, -t
  echo "${rubeimpatient}${reset}"
  echo ""
  echo "${bold}${white}View the full list online at ${red}http://www.rubegoldbash.com/${reset}"
  echo "${bold}${white}View your saved game at ${bold}${red}$gist_url${reset}"
  echo "${bold}${white}...Want a little extra? Try some \$ ${reset}telnet towel.blinkenlights.nl ${bold}${rubewink} ${white}(to escape, hit ${red}^]${white} and type ${red}quit${white})${reset}"
}
