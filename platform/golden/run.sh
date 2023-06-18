#!/bin/sh

mkdir -p ${PWD}/packer_logs

PACKER_LOG_PATH=${PWD}/packer_logs/log.txt PACKER_LOG=1 packer build bullseye.pkr.hcl
