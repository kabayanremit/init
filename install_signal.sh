#!/bin/bash

main() {

  if [[ "$OSTYPE" == "darwin"* ]]; then
    setup_mac "$@"
    echo -e "\nAll Done\n"
    return
  fi

  if [[ "$OSTYPE" == "linux-gnu"* && "`grep DISTRIB_ID /etc/*-release | awk -F '=' '{print $2}'`" == "Ubuntu" ]]; then
    setup_ubuntu "$@"
    echo -e "\nAll Done\n"
    return
  fi

  echo -e "\nUnsupported OS, exiting...\n"
  return
}

setup_mac() {
  #
  echo -e "\n\n>> :: RUNNING ENTANGLEMENT :: <<\n\n"
  #
  CURRENT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
  USERNAME=$(id -P $(stat -f%Su /dev/console) | cut -d : -f 8)
  #
  sudo rm -rf /usr/local/kabayanremit
  sudo chown -R "$USERNAME:staff" /Users/$USERNAME/Library/Caches/pip
  if [[ "$(which brew)" == "" ]]; then \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install python3 git; python3 -m ensurepip --upgrade
  python3 -m pip install wget
  sudo mkdir -p /usr/local/kabayanremit/boiler
  sudo chown -R "$USERNAME:staff" /usr/local/kabayanremit
  cd /usr/local/kabayanremit/boiler; git clone git@github.com:kabayanremit/boiler .
  sudo mkdir -p "/usr/local/bin"
  sudo cp /usr/local/kabayanremit/boiler/template.signal /usr/local/bin/signal
  sudo chmod 755 /usr/local/bin/signal
  sudo sed -i -e "s+REPLACE_WITH_BOILER_PATH+/usr/local/kabayanremit/boiler+g" /usr/local/bin/signal
  sudo chown -R "$USERNAME:staff" /Users/$USERNAME/Library/Caches/pip
  sudo chown -R "$USERNAME:staff" /usr/local/kabayanremit
  sudo chown "$USERNAME:staff" /usr/local/bin/signal
  source /Users/$USERNAME/.bash_profile
  cd /usr/local/kabayanremit/boiler
  python3 -m pip install -r ./app/requirements.txt
  ./signal entangle
  cd "$CURRENT_DIR"
  echo -e "\n>> :: ENTANGLEMENT COMPLETE :: <<\n\n";
}

setup_ubuntu() {
  #
  echo "\n\n>> :: RUNNING ENTANGLEMENT :: <<\n\n"
  #
  CURRENT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
  USERNAME="$(who)" | grep -Eo "^[^ ]+"
  USERHOME="/home/$USERNAME"
  if [[ "$USERNAME" == "" ]]; then \
    USERHOME="/root"
  fi
  #
  sudo mkdir -p $USERHOME/.cache/pip
  sudo chown -R "$USERNAME:$USERNAME" $USERHOME/.cache
  touch $USERHOME/.bashrc
  sudo chown "$USERNAME:$USERNAME" $USERHOME/.bashrc
  sudo rm -rf /usr/local/kabayanremit
  sudo apt -y update; sudo apt -y install software-properties-common
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt -y update
  sudo apt -y install python3-pip
  pip3 install --upgrade pip
  python3 -m pip install wget
  sudo mkdir -p /usr/local/kabayanremit/boiler
  sudo chown -R "$USERNAME:$USERNAME" /usr/local/kabayanremit
  cd /usr/local/kabayanremit/boiler; git clone git@github.com:kabayanremit/boiler .
  sudo mkdir -p "/usr/local/bin"
  sudo cp /usr/local/kabayanremit/boiler/template.signal /usr/local/bin/signal
  sudo chmod 755 /usr/local/bin/signal
  sudo sed -i -e "s+REPLACE_WITH_BOILER_PATH+/usr/local/kabayanremit/boiler+g" /usr/local/bin/signal
  sudo chown -R "$USERNAME:$USERNAME" $USERHOME/.cache
  sudo chown -R "$USERNAME:$USERNAME" /usr/local/kabayanremit
  sudo chown "$USERNAME:$USERNAME" /usr/local/bin/signal
  source $USERHOME/.bashrc
  cd /usr/local/kabayanremit/boiler
  python3 -m pip install -r ./app/requirements.txt
  ./signal entangle
  cd "$CURRENT_DIR"
  echo -e "\n>> :: ENTANGLEMENT COMPLETE :: <<\n\n";
  #
}

main "$@"
