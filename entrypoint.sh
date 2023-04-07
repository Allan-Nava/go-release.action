#!/bin/sh

set -eux

if [ -z "${CMD_PATH+x}" ]; then
  echo "::warning file=entrypoint.sh,line=6,col=1::CMD_PATH not set"
  export CMD_PATH=""
fi

FILE_LIST=`/build.sh`

#echo "::warning file=/build.sh,line=1,col=5::${FILE_LIST}"

EVENT_DATA=$(cat $GITHUB_EVENT_PATH)
echo $EVENT_DATA | jq .
UPLOAD_URL=$(echo $EVENT_DATA | jq -r .release.upload_url)
#
UPLOAD_URL=${UPLOAD_URL/\{?name,label\}/}
RELEASE_NAME=$(echo $EVENT_DATA | jq -r .release.tag_name)
PROJECT_NAME=$(basename $GITHUB_REPOSITORY)
NAME="${NAME:-${PROJECT_NAME}_${RELEASE_NAME}}_${GOOS}_${GOARCH}"
#
RELEASE_URL=$(echo $EVENT_DATA | jq -r .release.url) 
RELEASE_URL=$(echo $RELEASE_URL | awk '{n=split($0, a, "/"); print a[n]}')
RELEASE_URL="https://github.com/upload/releases/${RELEASE_URL}"
#
echo "RELEASE_URL ${RELEASE_URL}"
#
#echo ":: NAME=${NAME} | PROJECT_NAME=${PROJECT_NAME} ::"
if [ -z "${NAME+x}" ]; then
echo "::warning file=entrypoint.sh,line=24,col=1::NAME not set"
fi
if [ -z "${PROJECT_NAME+x}" ]; then
echo "::warning file=entrypoint.sh,line=28,col=1::PROJECT_NAME not set"
fi
#
#echo "PROJECT_NAME=${PROJECT_NAME} | NAME=$NAME | RELEASE_NAME=${RELEASE_NAME}"
if [ -z "${EXTRA_FILES+x}" ]; then
echo "::warning file=entrypoint.sh,line=33,col=1::EXTRA_FILES not set"
fi
#
FILE_LIST="${FILE_LIST} ${EXTRA_FILES}"
#
FILE_LIST=`echo "${FILE_LIST}" | awk '{$1=$1};1'`
#
#
if [ $GOOS == 'windows' ]; then
ARCHIVE=tmp.zip
zip -9r $ARCHIVE ${FILE_LIST}
else
ARCHIVE=tmp.tgz
tar cvfz $ARCHIVE ${FILE_LIST}
fi
#
export CHECKSUM=$(md5sum ${ARCHIVE} | cut -d ' ' -f 1)
#
curl \
  -X PUT \
  --data-binary "@${ARCHIVE}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -H 'Content-Type: application/octet-stream' \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${RELEASE_URL}?name=${NAME}.${ARCHIVE/tmp./}"
#
#
curl \
  -X POST \
  --data-binary "@${ARCHIVE}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -H 'Content-Type: application/octet-stream' \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${UPLOAD_URL}?name=${NAME}.${ARCHIVE/tmp./}"
#
curl \
  -X POST \
  --data $CHECKSUM \
  -H 'Content-Type: text/plain' \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${UPLOAD_URL}?name=${NAME}_checksum.txt"
#