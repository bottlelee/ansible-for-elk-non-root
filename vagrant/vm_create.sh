#!/bin/bash
set -e

case "$1" in
    destroy)
        vagrant destroy -f
    ;;
    snapshot)
        vagrant snapshot save $2
        ;;
    restore)
        vagrant snapshot restore $2
        ;;
    init)
        vagrant snapshot restore init
        ;;
    rebuilt)
        vagrant destroy -f
        vagrant up
        vagrant snapshot save init
        ;;
    *)
        echo "Usage: $0 {destroy|snapshot|restore|init}"
        exit 1
esac