#!/bin/bash

main() {
  (bash -c "cd ../nativer; ./var/run_ios.sh");
}

main "$@"
