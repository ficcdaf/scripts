#!/bin/env python
from argparse import ArgumentParser
import subprocess
import json 

# JSON object to represent a window in Niri
type WindowJson = dict[str, int | str | bool]

# Get a list of open windows from Niri
def get_windows():
    command = "niri msg -j windows"
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    data: list[WindowJson] = json.loads(process.communicate()[0])

    return data

# Generate a string representation for each window.
# Map the string to its Niri window ID
def get_string_id_mapping(window_list: list[WindowJson]):
    mapping: dict[str, int] = {}
    for idx, window in enumerate(window_list):
        s = f"{idx}: {window.get("title")}"
        id = window.get("id")
        assert type(id) == int
        mapping[s] = id
    return mapping

# Generate the string to be sent to fuzzel
def get_input_string(mapping: dict[str, int]):
    return "\n".join(mapping.keys())

def spawn_picker(cmd, input_string):
    # cmd = "fuzzel --dmenu -I --placeholder=Select a window:"
    process = subprocess.Popen(cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    selection = process.communicate(input=input_string.encode("UTF-8"))
    if process.returncode != 2:
        return selection[0].decode("UTF-8").strip("\n")
    else:
        return None

def switch_window(id: int):
    cmd = f"niri msg action focus-window --id {id}"
    process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    process.communicate()

if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("-p", "--picker", required=False, help="Set a picker command. Must take a newline delimited string on stdin and return the selection on stdout (default: %(default)s)", default="fuzzel --dmenu --placeholder=Select a window:", type=str, metavar="COMMAND")
    args = parser.parse_args()
    picker_cmd = args.picker
    # print("picker:", picker_cmd)
    wl = get_windows()
    mapping = get_string_id_mapping(wl)
    input_string = get_input_string(mapping)
    selection = spawn_picker(picker_cmd, input_string)
    if selection is None:
        exit(1)
    try:
        id = mapping[selection]
    except KeyError:
        exit(1)
    switch_window(id)
