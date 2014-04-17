#!/bin/bash

READ=0
LAST_BYTE=""

if [ -z "$CLIP_FILE" ]; then
  CLIP_FILE="~/.clip"
fi

if [ -t 0 ]; then
  READ=1
fi

debug () {
  if ! [ -z "$DEBUG" ]; then
    {
      printf "clip: debug: "
      echo "$@"
    } >&2
  fi
}

clip_empty () {
  if [ -z "`cat $CLIP_FILE`" ]; then
    return 0
  else
    LAST_BYTE="$byte"
    return 1
  fi
}

clip_exists () {
  if test -f "$CLIP_FILE"; then
    return 0
  else
    return 1
  fi
}

clip_create () {
  if ! clip_exists; then
    touch "$CLIP_FILE"
  fi
}

clip_destroy () {
  if clip_exists; then
    rm -f "$CLIP_FILE"
  fi
}

clip_read () {
  clip_create
  if clip_empty; then
    debug "empty"
    return 1
  else
    cat "$CLIP_FILE" | {
      while read line; do
        debug "read '$line'"
        echo $line
      done
    }
    return 1
  fi
}

clip_write () {
  clip_create
  while read -r line; do
    debug "write '$line'"
    echo "$line"
  done >> "$CLIP_FILE"
}

clip () {
  if [ "1" == "$READ" ]; then
    clip_read
  else
    clip_destroy
    clip_write
  fi
}

clip && exit $?;
