#!/bin/sh
eyeos-service-ready-notify-cli &
eyeos-run-server --serf mongod
