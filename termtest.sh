#!/bin/bash

# Define the text to be formatted
text="Hello_World!"

# Print text with different underline styles and strikethrough
echo -e "\e[4mStraight underline: $text\e[0m"          # Straight underline
echo -e "\e[24mNo underline: $text\e[0m"               # No underline (reset)
echo -e "\e[4:1mDouble underline: $text\e[0m"          # Double underline
echo -e "\e[4:2mCurly underline: $text\e[0m"           # Curly underline (not widely supported)
echo -e "\e[4:3mDotted underline: $text\e[0m"          # Dotted underline
echo -e "\e[4:4mDashed underline: $text\e[0m"          # Dashed underline
echo -e "\e[9mStrikethrough: $text\e[0m"              # Strikethrough
