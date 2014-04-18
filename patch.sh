#!/bin/sh
if [ -d sourcefix ]
then
	echo Patching source tree...
	cd sourcefix
	echo Replacing files...
	FILELIST=$(find .|grep --invert-match .patch)
	for FILETOPATCH in $FILELIST;
	do
		if [ -e ../$FILETOPATCH ]
		then
			cp $FILETOPATCH ../$FILETOPATCH
		else
			echo $FILETOPATCH does not exist
		fi
	done
	echo Done
	echo Applying .patch files
	FILELIST=$(find .|grep .patch)
	for FILETOPATCH in $FILELIST;
	do
		ORIGFILE=$(echo $FILETOPATCH|cut -d'.' --complement -f3)
		if [ -e ../$ORIGFILE ]
		then
			patch ../$ORIGFILE < $FILETOPATCH
		else
			echo $FILETOPATCH does not exist
		fi
	done
	echo Done
else
	echo No patches were downloaded
fi
