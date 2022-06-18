#!/bin/bash

main() {
  (bash -c "cd ../nativer; ./var/run_android.sh");
}

main "$@"
