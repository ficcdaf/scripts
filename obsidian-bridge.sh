#!/bin/bash
if [[ ! -f /tmp/.obsidian-api-key ]]; then
  pass show obsidian-bridge/api-key >/tmp/.obsidian-api-key
  chmod 600 /tmp/.obsidian-api-key
fi
OBSIDIAN_REST_API_KEY=$(cat /tmp/.obsidian-api-key)
export OBSIDIAN_REST_API_KEY
