#!/bin/env python
from argparse import ArgumentParser
import subprocess
import json 

def get_windows():
    command = "niri msg -j windows"
    process = subprocess.Popen(command, shell=True)
