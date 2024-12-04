#!/bin/bash

gpg ./obsidian-bridge.crt.gpg
sudo trust anchor --store obsidian-bridge.crt
