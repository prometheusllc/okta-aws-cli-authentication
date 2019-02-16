#!/bin/bash

export profile=$1
source ~/.bash_profile
cd ~/ && okta-aws $profile
