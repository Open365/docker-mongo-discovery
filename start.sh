#!/usr/bin/env bash
eyeos-service-ready-notify-cli &
eyeos-run-server --serf --skip-dnsmasq mongod
