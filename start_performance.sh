#!/bin/bash
URL_FILE=./urls.txt

###################################
# Fall back to local installed http_load if executable not found
###################################
if which http_load 2>/dev/null; then
        HTTP_LOAD_EXEC=http_load
else
        HTTP_LOAD_EXEC=./http_load
fi

###################################
# Execute performance measurement
###################################

remote_host=$(echo "$url" | sed -e 's/http:\/\//\n/g' | awk -F. '{ print $1 }')
output_file="./measurements/$(<hostname)_to_${remote_host}_$(date +%Y-%m-%d_%H-%M).csv"

echo "mean,max,min" > ${output_file}
for i in {1..5}
do
        output=$(${HTTP_LOAD_EXEC} -rate 10 -seconds 1 ${URL_FILE})
        response=$(echo "$output" | grep msecs/first-response)
        mean=$(echo $response | awk -F\  '{ print $2 }')
        max=$(echo $response | awk -F\  '{ print $4 }')
        min=$(echo $response | awk -F\  '{ print $6 }')

        echo "[$i] Mean/Max/Min response time: ${mean}/${max}/${min}"

        echo "${mean},${max},${min}" >> ${output_file}
done
