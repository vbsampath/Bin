#!/usr/bin/bash

halium=$HOME'/halium'
changes=$HOME'/HaliumChanges'
git_status_report=$changes'/git_report.csv'
repos=$HOME'/github/repositories'
declare -A dirs

dirs['/halium/hybris-boot/']='hybris-boot'
dirs['/halium/devices/']='halium-devices'
dirs['/kernel/samsung/exynos5433/']='android_kernel_samsung_exynos5433'
dirs['/device/samsung/trelte-common/']='android_device_samsung_trelte-common'
dirs['/hardware/samsung/']='android_hardware_samsung'

printf '%s\n' "base_path" "file" "repo_name" "change" | paste -sd ',' >> $git_status_report

### Check for dir, if not found create it using the mkdir ##
[ ! -d "$changes" ] && mkdir -p "$changes"

cd $halium
## copy the changes into seperate directory for safe keeping and tracking
process_file_changes(){
    local base_path=$1
    local file=$2
    local path=$base_path/$file
    local relative_path=$(echo $(dirname "$path") | cut -c 20-)
    local matching_base_path=$(echo $base_path | cut -c 20-)
    ##echo $relative_path
    #echo $matching_base_path
    repo_path=${dirs[$matching_base_path/]}
    #echo $repo_path
    [ ! -d $changes/$relative_path ] && mkdir -p $changes/$relative_path
    cp $path $changes/$relative_path
    printf '%s\n' $base_path $file $repo_path $path | paste -sd ',' >> $git_status_report

}

## check if folder contains git and then append git status into a report
check_git_status(){
    local git_dir=".git"
    local dir=$1
    local base_path=$(echo $(dirname "$dir"))
    cd $1
    cd ..
    if [ -d "$git_dir" ]; then
        git_modified_files=($(git ls-files -m))
        git_other_files=($(git ls-files -o))

        for modified_filelist in "${git_modified_files[@]}"; do
            process_file_changes $base_path $modified_filelist
        done
        for other_filelist in "${git_other_files[@]}"; do
            process_file_changes $base_path $other_filelist
        done
    fi
}

readarray -d '' git_directories < <(find $halium -type d -name ".git" -o -path "$halium/.repo" -prune -o -path "$halium/build" -prune )

for dir in $git_directories; do
    check_git_status $dir
done
