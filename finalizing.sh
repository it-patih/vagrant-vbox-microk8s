#!/bin/bash

echo "###"
echo "### configure-docker-rootless.sh ###"
echo "###"

echo "> remove microk8s from sudo"
deluser microk8s sudo