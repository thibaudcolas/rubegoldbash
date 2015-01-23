# Font: Modified Doom + Smushed Slant
echo "\033[0;32m" '______         _            _____         _      _                           ' "\033[0m"
echo "\033[0;32m" '| ___ \       | |          |  __ \       | |    | |     ____             __  ' "\033[0m"
echo "\033[0;32m" '| |_/ / _   _ | |__    ___ | |  \/  ___  | |  __| |    / __ )____ ______/ /_ ' "\033[0m"
echo "\033[0;32m" '|    / | | | ||  _ \  / _ \| | __  / _ \ | | / _  |   / __  / __ // ___/ __ \' "\033[0m"
echo "\033[0;32m" '| |\ \ | |_| || |_) ||  __/| |_\ \| (_) || || (_| |  / /_/ / /_/ (__  ) / / /' "\033[0m"
echo "\033[0;32m" '\_| \_| \____||____/  \___| \____/ \___/ |_| \____/ /_____/\____/____/_/ /_/ ' "\033[0m"
echo "\033[0;32m"'....is now installed!'"\033[0m"
echo "\n\n \033[0;32mp.s. Follow us at http://twitter.com/TODO.\033[0m"

# Configure history to work the way we want to.
HISTFILE=~/.rubegoldbash_history
HISTIGNORE=ls:'cd:cd -:pwd:exit:date:* --help:ls:'
HISTTIMEFORMAT='%F %T '
HISTSIZE=10000
SAVEHIST=10000
HISTCONTROL=ignorespace:ignoredups:erasedups
