#! /usr/bin/env sh


get_all_sinks() {
  pactl list short sinks | cut -f 2
}

get_default_sink() {
  #pw-play --list-targets | grep \* | tail -n 1 | cut -d' ' -f 2 | cut -d : -f 1
  pactl info | grep 'Default Sink' | cut -d':' -f 2
}

DEF_SINK=$(get_default_sink)
for SINK in $(get_all_sinks) ; do
  [ -z "$FIRST" ] && FIRST=$SINK # Save the first index in case the current default is the last in the list

if [ " $SINK" = "$DEF_SINK" ]; then
    NEXT=1;
  elif [ -n "$NEXT"  ]; then
    NEW_DEFAULT_SINK=$SINK
    break
  fi
done

[ -z "$NEW_DEFAULT_SINK" ] && NEW_DEFAULT_SINK=$FIRST;

pactl set-default-sink "$NEW_DEFAULT_SINK"

pactl set-sink-mute @DEFAULT_SINK@ off
pactl set-sink-volume @DEFAULT_SINK@ 100%


