#! /dev/null/bash

# Add pre-determined keys to ssh keychain.
ssh-add -k ~/.ssh/id.load/id_* 2>&1 |
    sed '/^Identity added: /d'
