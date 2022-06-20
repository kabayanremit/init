Installation:

[mac]
if [[ "$(which brew)" == "" && "$(which curl)" == "" ]]; then /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; fi; if [[ "$(which curl)" == "" ]]; then brew install curl; fi; curl -sL https://raw.githubusercontent.com/kabayanremit/init/main/install_signal.sh -o ~/install_signal.sh; /bin/bash ~/install_signal.sh;

[ubuntu]
if [[ "$(which curl)" == "" ]]; then sudo apt -y update; sudo apt install -y curl; fi; curl -sL https://raw.githubusercontent.com/kabayanremit/init/main/install_signal.sh -o ~/install_signal.sh; /bin/bash ~/install_signal.sh;
