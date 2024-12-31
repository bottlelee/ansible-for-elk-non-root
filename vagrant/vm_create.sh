#!/bin/bash
set -e

vagrant destroy -f
vagrant up
vagrant reload
vagrant snapshot save init
