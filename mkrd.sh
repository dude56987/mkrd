#! /bin/bash
########################################################################
# Make a ram disk with a GUI
# Copyright (C) 2015  Carl J Smith
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
########################################################################
# make the directory of the ramdisk
mkdir -p /tmp/RAMDISK
# find total ram
totalRam=$(free -m | grep -oP '\d+' | head -n 1)
echo "total ram=$totalRam"
# set the size of the ramdisk
echo "Launching dialog..."
diskSize=$(zenity --scale --text="Select the size of ramdisk in MEGABYTES?" --value=0 --min-value=0 --max-value=$totalRam --step=25)
#dialog --rangebox --stderr "How large would you like the ramdisk in Megabytes to be?" 0 0 32 8000 512
anwser=$?
diskSize=$diskSize"K"
echo "diskSize=$diskSize"
echo "anwser=$anwser"
if [ $anwser -eq 1 ];then
	echo "Canceling ramdisk creation..."	
else
	# mount the directory with ramdisk
	umount /tmp/RAMDISK 
	mount -t tmpfs -o size=$diskSize tmpfs /tmp/RAMDISK
	echo "Ram Disk will be removed on next boot..."
fi
