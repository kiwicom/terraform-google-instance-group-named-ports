#!/bin/bash -ex

TMP_DIR=$(mktemp -d)
function cleanup() {
  rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

if [[ ! -z ${GOOGLE_CREDENTIALS+x} && ! -z ${TF_VAR_GOOGLE_PROJECT+x} ]]; then
  export CLOUDSDK_CONFIG=${TMP_DIR}
  gcloud auth activate-service-account --key-file - <<<"${GOOGLE_CREDENTIALS}"
  gcloud config set project "${TF_VAR_GOOGLE_PROJECT}"
fi

RES=$(gcloud compute instance-groups set-named-ports ${INSTANCE_GROUP} --named-ports="${NAMED_PORTS}")
