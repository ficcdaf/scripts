#!/bin/env python3

# Depends: wtype

from argparse import ArgumentParser
from configparser import ConfigParser
import os
import subprocess

ENV_CONFIG = "FOOT_CONFIG"
ENV_PICKER = "FOOT_PICKER"
DEFAULT_CONFIG = "$HOME/.config/foot.ini"


def parse_config(path: str):
    config = ConfigParser(allow_unnamed_section=True)
    config.read(path)
    section = "key-bindings"
    pairs: list[tuple[str, str]] = config.items(section, raw=True)
    out: dict[str, str] = {}
    for pair in pairs:
        command = pair[0] 
        bindings = pair[1].split(" ")
        # print(bindings)
        # check if it's one of the pipe commands
        if bindings[0] == "none":
            continue
        elif bindings[0][0] == "[":
            out[command]= bindings[1]
        else:
            out[command] = bindings[0]
        # print(out[command])
    return out


def get_query_string(mapping: dict[str, str]) -> str:
    return "\n".join(mapping.keys())


def spawn_picker(cmd, query_string):
    process = subprocess.Popen(
        cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE
    )
    selection = process.communicate(input=query_string.encode("UTF-8"))
    if process.returncode != 2:
        return selection[0].decode("UTF-8").strip("\n")
    else:
        return None


MOD_MAP = {
    "Control": "ctrl",
    "Shift": "shift",
    "Mod1": "alt",
}


def get_wtype_args(selection: str, mapping: dict[str, str]):
    binding = mapping[selection]
    args: list[str] = ["wtype"]
    for k in binding.split("+"):
        if k in MOD_MAP:
            args += ["-M", MOD_MAP[k]]
        else:
            args += ["-k", k]
    return args


def send_keys(args):
    process = subprocess.run(args)
    process.check_returncode()


def validate_path(path: str) -> str:
    if path == DEFAULT_CONFIG:
        return str(os.environ["HOME"]) + "/.config/foot/foot.ini"
    else:
        return path


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "-c",
        "--config",
        required=False,
        help="Absolute path to foot.ini file. (default: %(default)s)",
        default=DEFAULT_CONFIG,
        type=str,
        metavar=ENV_CONFIG,
    )
    parser.add_argument(
        "-p",
        "--picker",
        required=False,
        help="Picker command to be used. (default: %(default)s)",
        type=str,
        default="fuzzel --dmenu --placeholder=Select a command:",
        metavar=ENV_PICKER,
    )
    args = parser.parse_args()
    picker = args.picker
    foot_path = validate_path(args.config)
    mapping = parse_config(foot_path)
    query = get_query_string(mapping)
    selection = spawn_picker(picker, query)
    if selection is not None:
        wtype_args = get_wtype_args(selection, mapping)
        print(wtype_args)
        send_keys(wtype_args)
    
