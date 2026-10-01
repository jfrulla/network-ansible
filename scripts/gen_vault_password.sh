#!/bin/bash

if [  $# -le 1 ] ; then
  echo "Generates ansible-vault entry to add to a groupvars 'vault' file." 1>&2
  echo "Usage: $0 < secret name > < 'password' >" 1>&2
  echo
  echo "Example: $0 vault_example_secret 'gh6?|$>2gbF'"
  echo 1>&2
  exit 1
fi

echo -n "$2" | ansible-vault encrypt_string --stdin-name "$1"
exit $?
