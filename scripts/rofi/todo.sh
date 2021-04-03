#!/usr/bin/env zsh

# Usage
# Execute using `./todo.sh + Something i need to do`
# The `+` indicates adding a new todo
#
# Using rofi `rofi -modi TODO:/path/to/this/script/todo.sh -show TODO`
# Type "+ Something i need to do" (without quotes) in the rofi launcher

TARGET_FILE="$HOME/todo.txt"
LINE="$*"

if [[ ! -a "$TARGET_FILE" ]]; then
    touch "$TARGET_FILE"
fi

function add() {
  sed -i -e '$a\' "$TARGET_FILE"
  printf '%s' "$(date --iso-8601) $*" >> "$TARGET_FILE"
}

if [ -z "$LINE" ]; then
  # List current todos
  cat "$TARGET_FILE"
else
  # Add a new entry to TARGET_FILE (strips leading '+' and whitespace)
  if [[ $LINE == "+"* ]]; then
    add "$(printf '%s' "$LINE" | sed -e 's/^+//g' -e  's/^[ \t]*//')"
  fi
fi