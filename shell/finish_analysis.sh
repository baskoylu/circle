#!/bin/bash

user=$1
date=$2

echo "Copy files from cluster local drive? (y/n)"
PROCEED="n"
read PROCEED
if [ $PROCEED == "y" ]; then
        echo "Copying .linkedTracks and .stim files to local G:/ drive."
        for folder in /mnt/x/circle_data_local/$date/*; do
                prefix=${folder##*/}
                scp $USER@openmind.mit.edu:/om/user/$USER/data/circle_data_cluster/$date/$prefix/${prefix}.linkedTracks.mat $folder
                cp /mnt/c/users/$user/documents/stimfiles/$date/${prefix}.stim $folder
        done
fi


echo


echo "Copy files from local drive to server? (y/n)"
read PROCEED
if [ $PROCEED == "y" ]; then
        echo "Copying .linkedTracks, .stim, and .avi files to the server."
        ssh $user@flv-c1.mit.edu "mkdir /data1/prj_risk/data/$date/"
        for folder in /mnt/x/circle_data_local/$date/*; do
                scp -r $folder $user@flv-c1.mit.edu:/data1/prj_risk/data/$date/
        done
fi
