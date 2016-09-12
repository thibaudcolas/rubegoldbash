# ______         _            _____         _      _
# | ___ \       | |          |  __ \       | |    | |    ____             __
# | |_/ / _   _ | |__    ___ | |  \/  ___  | |  __| |   / __ )____ ______/ /_
# |    / | | | ||  _ \  / _ \| | __  / _ \ | | / _  |  / __  / __ // ___/ __ \
# | |\ \ | |_| || |_) ||  __/| |_\ \| (_) || || (_| | / /_/ / /_/ (__  ) / / /
# \_| \_| \____||____/  \___| \____/ \___/ |_| \____//_____/\____/____/_/ /_/
# https://github.com/thibaudcolas/rubegoldbash
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
  reset='';
  black='';
  blue='';
  cyan='';
  green='';
  orange='';
  purple='';
  red='';
  violet='';
  white='';
  yellow='';
fi;

rubehappy="${orange}(◕‿◕)${yellow}";
rubemeh="${orange}(◕_◕)${yellow}";
rubeeager="${orange}(っ◕‿◕)っ${yellow}";
rubeimpatient="${orange}(づ◕‿◕｡)づ${yellow}";
rubethinking="${orange}(◕‿◕｡)${yellow}";
rubeyay="${orange}(ﾉ◕ヮ◕)ﾉ${yellow}";
rubepoker="${orange}༼ つ ◕_◕ ༽つ${yellow}";
rubewink="${orange}◕‿↼${yellow}";

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
echo ""
echo "${bold}${rubepoker} I'm ${orange}Rube${yellow}, the command-line guru. Nice to meet you, ${orange}$(whoami).${reset}"
echo "${bold}${rubeeager} Can you do some Rube Goldberg bash for me? A lot of pipes (${white}|${yellow}), please!${reset}"
echo ""

# Calculates the player score!
export BESTSCORE=$((0))
export FIRST=$((0))
export STAGE=$((0))
function score_game() {
  local combo='|'

  if [ -n "$BASH_VERSION" ]; then
    history -a
    history -c
    history -r
  fi

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

  if [[ "$FIRST" -eq 0 ]]; then
    export FIRST=$((1))
    echo "${bold}${rubewink} If you need help with commands, try this: ${white}http://explainshell.com/${reset}"
    echo "${bold}${rubethinking} You can share your score with the world by using the ${white}rubeshare${yellow} command."
  else
    echo "${rubeface} Command Score:${white} $command_score${yellow}, Best: ${white}$BESTSCORE${reset}"
  fi;

  echo ""

  if (( $BESTSCORE > 500 )); then
    export STAGE=5
  elif (( $BESTSCORE > 200 )); then
    export STAGE=4
  elif (( $BESTSCORE > 100 )); then
    export STAGE=3
  elif (( $BESTSCORE > 50 )); then
    export STAGE=2
  elif (( $BESTSCORE > 20 )); then
    export STAGE=1
  fi;

  case "$STAGE" in
    0 )
        echo "${bold}${rubethinking} Let's start with something simple, some ${white}ls -la ~${yellow} for example.${reset}"
        echo "${bold}${rubeyay} And then we can try some basic piping! ${white}ls -la ~ | grep bash${yellow}.${reset}"
    ;;
    1 )
        echo "${bold}${rubeyay} You did it! ... but that was easy, I told you what to do!${reset}"
        echo "${bold}${rubethinking} You can share your score with the world by using the ${white}rubeshare${yellow} command."
        echo "${bold}${rubehappy} Ok, let's go a little bit further. Pipe the previous command into ${white}wc -l${yellow}.${reset}"
    ;;
    2 )
        echo "${bold}${rubeeager} That was fast, we need to go deeper! ${red}Web Scraping${yellow} is an ancient dark art.${reset}"
        echo "${bold}${rubeimpatient} Behold the power of ${white}curl${yellow}! ${white}curl -s whenwillitbedone.trgdy.com${yellow}.${reset}"
        echo "${bold}${rubeeager} You can use ${white}grep${yellow} and ${white}sed${yellow} to only keep the good stuff: ${white}grep '<p>'${yellow}, ${white}sed 's/<p>//g'${yellow}.${reset}"
    ;;
    3 )
        echo "${bold}${rubepoker} ${red}Powerful you have become, the dark side I sense in you.${reset}"
        echo "${bold}${rubemeh} Use your powers for good, not for evil! But here's some nice cool black magic:${reset}"
        echo "${bold}${rubeyay} ${white}lynx -dump twitter.com/globalgamejam | head -n150 | tail -n30 | grep -v '(BUTT'${reset}"
    ;;
    4 )
        echo "${bold}${rubepoker} ${red}If you end your training now — if you choose the quick and easy path as Vader did — you will become an agent of evil.${reset}"
        echo "${bold}${rubeyay} ${white}xargs -n 1${yellow} is a powerful weapon, not to use lightly — that said, try it with ${white}curl${yellow}.${reset}"
        echo "${bold}${rubemeh} Always pass on what you have learned. - by using the ${white}rubeshare${yellow} command.${reset}"
    ;;
    5 )
        echo "${bold}${rubethinking} I have nothing more to teach you, my young apprentice. Let's ${white}rubeshare${yellow}.${reset}"
        echo "${bold}${rubewink} You proved yourself worthy, here's something you might enjoy:${reset}"
        echo "${bold}${rubewink} ${white}telnet towel.blinkenlights.nl ${yellow}(to exit, hit ${red}^]${white} and type ${red}quit${white})${reset}"
    ;;
  esac;
}

function rubesay() {
  if hash say 2>/dev/null; then
    local voice=$([ $[ $RANDOM % 2 ] == 0 ] && echo "Victoria" || echo "Alex")
    say -v $voice "$@"
  fi
}

function write_history() {
  if [ -n "$ZSH_VERSION" ]; then
    fc -AI
  elif [ -n "$BASH_VERSION" ]; then
    history -w
  fi
}

# Configure history to work the way we want to.
export HISTFILE=~/.rubegoldbash_history
write_history
rm -f ~/.rubegoldbash_history
touch ~/.rubegoldbash_history
export HISTIGNORE=''
export HISTTIMEFORMAT='%T $ '
export HISTSIZE=10000
export SAVEHIST=10000
export HISTCONTROL=ignoreboth:erasedups

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";

if [ -n "$ZSH_VERSION" ]; then
  precmd() { score_game; }
elif [ -n "$BASH_VERSION" ]; then
  # When the shell exits, append to the history file instead of overwriting it
  shopt -s histappend
  # Case-insensitive globbing (used in pathname expansion)
  shopt -s nocaseglob;
  # Autocorrect typos in path names when using `cd`
  shopt -s cdspell;

  # After each command, append to the history file and reread it
  export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}score_game"
fi

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

if [ -n "$ZSH_VERSION" ]; then
  # Set the terminal title to the current working directory.
  PS1="${userStyle}%n"; # username
  PS1+="${white} playing ";
  PS1+="${cyan}RubeGold${green}Bash"; # host
  PS1+="${white} in ";
  PS1+="${green}%d"; # working directory
  PS1+="${white} — ";
  PS1+="${rubethinking}";
  PS1+="${yellow} What do we do now?";
  PS1+="
";
  PS1+="${white}\$ ${reset}"; # `$` (and reset color)

  PS2="${yellow}→ ${reset}";
else
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
  PS1+="\[${yellow}\] What do we do now?";
  PS1+="\n";
  PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)

  PS2="\[${yellow}\]→ \[${reset}\]";
fi

export PS1;
export PS2;

# Share your results online!
function rubeshare() {
  write_history

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
  rubesay "$message You scored $BESTSCORE points!"
  echo "${white}...Uploading ${bold}${userStyle}$(whoami)${white}'s ${cyan}RubeGold${green}Bash ${white}game — ${orange}$(date)${reset}"

  #TODO Find another way to serialize JSON
  # local player_history=$(cat $HISTFILE | sed '/^#/ d' | sed ':a;N;$!ba;s/\n/ /g')
  #TODO Destub
  local player_history=$(cat $HISTFILE | tail -n 1 | sed '/^#/ d' | sed ':a;N;$!ba;s/\n/ /g')
  player_history="${player_history//\"/\\\"}"
  player_history="${player_history//\n/\\n}"
  local gist_upload='{"public": true,"description": "'"$description"'","files": {"history.sh": {"content": "'"$player_history"'"}}}'
  local gist_response=$(curl --silent -X POST -d "$gist_upload" https://api.github.com/gists)
  # local gist_response='{"html_url": "https://gist.github.com/banana","test":true}'
  local gist_url=$(echo $gist_response | grep -o "https://gist.github.com/[a-z0-9]*" | head -n 1)
  local gist_hash=$(echo $gist_url | cut -d '/' -f 4)

  echo ""
  echo "${bold}${yellow}" '____________________________________________________________' "${reset}"
  echo "${bold}${red}"    ' _  _   _          _        ___                             ' "${reset}"
  echo "${bold}${red}"    '| || | (_)  __ _  | |_     / __|  __   ___   _ _   ___   ___' "${reset}"
  echo "${bold}${red}"    '| __ | | | / _` | | ` \    \__ \ / _| / _ \ | `_| / -_) (_-<' "${reset}"
  echo "${bold}${red}"    '|_||_| |_| \__, | |_||_|   |___/ \__| \___/ |_|   \___| /__/' "${reset}"
  echo "${bold}${red}"    '           |___/                                            ' "${reset}"
  echo "${bold}${yellow}" '____________________________________________________________' "${reset}"
  echo ""
  curl --silent -X POST --data "player=$(whoami)&score=$BESTSCORE&gist=$gist_hash" http://highscore.rubegoldbash.com/scores.txt | column -s, -t
  # curl --silent http://highscore.rubegoldbash.com/scores.txt | column -s, -t
  echo "${rubeimpatient}${reset}"
  echo ""
  echo "${bold}${white}View the full list online at ${red}http://www.rubegoldbash.com/${reset}"
  echo "${bold}${white}View your saved game at ${bold}${red}$gist_url${reset}"
  echo "${bold}${rubewink} Wanna try something else? ${white}telnet towel.blinkenlights.nl ${yellow}(to exit, hit ${red}^]${white} and type ${red}quit${white})${reset}"
  echo ""
}
