#!/usr/bin/env bash

# Daemon; log file; config location; environment; directory in which Rails app is located
bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e production -r server
