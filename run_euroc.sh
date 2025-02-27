#!/bin/bash

path=$1
output=$2

mkdir -p "$output"
if [[ -e "$path"  ]]; then
    if [[ -f "$path/mav0/imu0/data.csv" ]]; then
        ./build/orcvio $path/mav0/imu0/data.csv \
        $path/mav0/cam0/data.csv \
        $path/mav0/cam0/data \
        $output/ \
        config/euroc.yaml
        python scripts/convert_csv_to_txt.py $path/mav0/state_groundtruth_estimate0/data.csv $output/stamped_groundtruth.txt
    elif [[ -e "$path/acl_jackal/forward-imu/data.csv" ]]; then
        ./build/orcvio $path/acl_jackal/forward-imu/data.csv \
                       $path/acl_jackal/forward-infra1/data.csv \
                       $path/acl_jackal/forward-infra1/data \
                       $output/ \
                       config/rs_d435i.yaml
    else
        echo "bad dataset dir. $path."
    fi
else
    echo "No dataset dir. For example, ./run_euroc /PATH_TO_EUROC/ "
fi



