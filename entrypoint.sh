#!/usr/bin/env bash

set -euo pipefail

# Run scripts to configure/prepare environment in runtime
if [[ -d "/entrypoint.d" ]] ; then
  for script in /entrypoint.d/* ; do
    if [[ -x "${script}" ]] ; then
      "${script}"
    fi
  done
fi

# Prepare stuff for running daemons
mkdir -p /run/php

# Run supervisord
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
