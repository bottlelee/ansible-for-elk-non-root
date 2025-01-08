#!/bin/bash
set -e

vagrant destroy -f
vagrant up
vagrant snapshot save init
