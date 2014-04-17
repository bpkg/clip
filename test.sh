#!/bin/bash

debug () {
  if ! [ -z "$DEBUG" ]; then
    {
      printf "debug: "
      echo "$@"
    } >&2
  fi
}

clip=./clip.sh

debug "ensuring empty clip"
{
  curr="`$clip`"
  if ! [ -z "$curr" ]; then
    {
      echo "error: invalid clip state"
      exit 1
    } >&2
  fi
}

debug "ensuring write"
{
  out=foo
  echo $out | $clip
  curr="`$clip`"
  if [ "$out" != "$curr" ]; then
    {
      echo "error: '$out' != '$curr'"
      exit 1
    } >&2
  fi
}

debug "cleaning up"
rm -f "$CLIP_FILE";

echo "ok!"
