#!/usr/bin/bash

input=""
halium=$HOME'/halium'
repos=$HOME'/Programs/github/repositories'
dry_run=True

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Sync git_report.csv changes to repositories"
   echo
   echo "Syntax: sync_halium_repos.sh [-d|h|r]"
   echo "options:"
   echo "d     Dry run, no changes are made yet log file will be generated"
   echo "h     Print this Help."
   echo "r     Real mode where changes are made"
   echo
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################

if [ "$#" -ne 1 ]; then
    Help
fi

############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":hd:r:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      d) # Enter file name
         input=$OPTARG;;
      r) # Enter file name
         dry_run=False
         input=$OPTARG;;
   esac
done


# Create a log file
touch rsync.log

# Read git_report.csv file
while IFS=',' read -ra array; do
  base_path+=("${array[0]}")
  file+=("${array[1]}")
  repo_name+=("${array[2]}")
  change+=("${array[3]}")
done < $input
#printf '%s\n' "${base_path[@]}" "${repo_name[@]}" "${change[@]}"


# Process csv file and do rsync for each file and log its output
for ((i = 1; i < ${#base_path[@]}; ++i)); do
    repo_path=$repos/${repo_name[$i]}
    repo_file_path=$repo_path/${file[$i]}
    change_path=${change[$i]}
    echo $repo_file_path | tee -a rsync.log
    #echo $change_path

    if [[ "$dry_run" = true ]] ; then
        rsync -avi --dry-run --delete --progress $change_path $repo_file_path | tee -a rsync.log
    else
        rsync -avi --delete --progress $change_path $repo_file_path | tee -a rsync.log
    fi
done
