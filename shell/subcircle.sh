#!/bin/bash
#
#SBATCH --output=/home/%u/log/circle_%j.txt
#SBATCH -n1
#SBATCH --job-name=circle
#SBATCH --nodes=1
#SBATCH --mem=40000
#SBATCH --time=100:00:00

# $1: Name of video
date=$1
vidname=$2

# Load matlab and launch tracker command.
module add mit/matlab/2014a
matlab -nodisplay -r "addpath(genpath('/home/$USER/circle')), addpath(genpath('/om2/user/$USER/data/circle_data_cluster')), TrackerAutomatedScript2('/om2/user/$USER/data/circle_data_cluster/$date/$vidname/${vidname}.avi', 'scale', '/home/$USER/circle/measure/measureCam.avi', 'NumWorms', [30, 200]), exit;"
