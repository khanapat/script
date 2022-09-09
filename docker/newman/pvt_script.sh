#!/bin/sh
export SOURCE_PATH=$(pwd)
export CONTAINER_POSTMAN_PATH=/newman
export POSTMAN_COLLECTION=/newman/script/VRT_PVT.postman_collection.json
export POSTMAN_ENVIRONMENT=/newman/script/VRT_PVT.postman_environment.json
export REPORT_HTML=/newman/output/html/index.html


docker run -v $SOURCE_PATH:$CONTAINER_POSTMAN_PATH -t kcsgbcdrg01.kcs:5000/vrt/newman:2.0.1 \
    run $POSTMAN_COLLECTION \
    --environment=$POSTMAN_ENVIRONMENT \
    --delay-request 10000 \
    --insecure \
    --reporters cli,html,junit \
    --reporter-html-export $REPORT_HTML

#กรณีที่ไม่มี entrypoint "newman"
docker run --name newman -v $(pwd):/newman -t newman:1.0.0 newman run /newman/script/beginner.postman_collection.json -e /newman/script/beginner.postman_environment.json --delay-request 100000 --reporters cli,html --reporter-html-export /newman/output/outputfile.html

#กรณีที่มี entrypoint "newman"
docker run --name newman -v $(pwd):/newman -t newman:1.0.0 run /newman/script/beginner.postman_collection.json -e /newman/script/beginner.postman_environment.json --delay-request 1000 --reporters cli,html --reporter-html-export /newman/output/outputfile.html