#!/bin/sh

PACKER_LOG_PATH=$HOME/packer.log PACKER_LOG=1 packer build bullseye.pkr.hcl
