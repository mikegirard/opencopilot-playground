#!/usr/bin/env bash

HELM_CHART=openCopilot-engineering
SCRIPT_DIR=$(dirname $0)
cd "${SCRIPT_DIR}"

IMAGE_TAG=$1
ENVIRONMENT=$2
NAMESPACE=${3:-$2}

usage() {
  echo "USAGE: update.sh IMAGE_TAG ENVIRONMENT NAMESPACE?"
  echo "   IMAGE_TAG: Valid tag of docker image"
  echo "   ENVIRONMENT: Name of the values to deploy (qa, staging, production) "
  echo "   NAMESPACE: K8s namespace (ENVIRONMENT value will be used if left blank) "
  echo ""
}

if [[ $# -lt 2 ]]
then
  usage
  exit 1
fi

helm upgrade --install --values ../${HELM_CHART}/values-${ENVIRONMENT}.yaml \
    --set-string "image.tag=${IMAGE_TAG}" \
    --namespace ${NAMESPACE} \
    --wait \
    --history-max 2 \
    ${HELM_CHART} ../${HELM_CHART} \
&& echo "Complete"

