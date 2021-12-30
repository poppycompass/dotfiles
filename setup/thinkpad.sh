# All you need is thinkpad.

#xinput --list --short
#xinput --list-props <id>

SPEED=1.0
TrackPointID=`xinput --list --short | perl -ne 'if ($_=~/TrackPoint/) {s/.*id=(\d+).*/$1/; print $_}'`
TrackPointAS=`xinput --list-props ${TrackPointID} | perl -ne 'if ($_=~/Accel Speed \(/) {s/.*\((.+?)\).*/$1/; print $_}'`
##xinput --set-prop ${TrackPointID} ${TrackPointAS} ${SPEED} # 0~1.0, make mouse pointer fast

TouchPadID=`xinput --list --short | perl -ne 'if ($_=~/TouchPad/) {s/.*id=(\d+).*/$1/; print $_}'`
#xinput --disable ${TouchPadID} # disable touchpad
