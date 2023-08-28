#!/usr/bin/env bash
HELM_CHART=openCopilot-engineering
SCRIPT_DIR=$(dirname $0)

ENVIRONMENT=$2

usage() {
  echo "USAGE: delete.sh ENVIRONMENT"
  echo "   ENVIRONMENT: namespace from which to delete. "
  echo ""
}

if [[ $# -lt 1 ]]
then
  usage
  exit 1
fi

helm uninstall --namespace ${ENVIRONMENT} ${HELM_CHART}

