#!/bin/sh
#create string with info -> only the first 10 lines
INFO=$(xrandr --current --verbose | head -n 10)

#make sure that the captured lines are relative of the monitor's laptop
if [grep -q '$2' $INFO] && [grep -q "connected" $INFO] && [grep -q 'Brightness:' $INFO]

#give the current brightness
CURRBRIGHT=$(grep -m 1 'Brightness:' $INFO | cut -f2- -d:)

then 
#comparision in order to determinate if up or down the brightness
if [ "$1" = "+" ] && [ $(echo "$CURRBRIGHT < 1" | bc) -eq 1 ] 
then
xrandr --output $2 --brightness $(echo "$CURRBRIGHT + 0.1" | bc)
elif [ "$1" = "-" ] && [ $(echo "$CURRBRIGHT > 0" | bc) -eq 1 ] 
then
xrandr --output $2 --brightness $(echo "$CURRBRIGHT - 0.1" | bc)
fi
