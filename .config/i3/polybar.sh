#!/bin/sh

if ! pgrep -u $USER -x polybar > /dev/null; then
    polybar
fi
