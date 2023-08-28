#! /bin/bash

CHART=$1
RELEASES=

function usage() {
  echo "This script takes in a single helm release name and allows "
  echo "  you to patch the release so a new 'helm upgrade' command will work."
  echo ""
  echo "You must first set your context to the proper cluster and namespace, then "
  echo "  you can check for helm charts installed by running 'helm list'"
}

function do_patch_process() {
  echo "The following failed helm upgrade releases were found. Select the one you wish to patch to 'Deployed'."
  select REL in $RELEASES
  do
    kubectl patch secret "sh.helm.release.v1.${REL}" --type=merge -p '{"metadata":{"labels":{"status":"deployed"}}}'
  done

}

if [ -z "$CHART" ]; then
  usage
  exit 1
else
  case "$CHART" in
    "-?"|"--help"|"-h")
    usage
    exit 1
    ;;
  esac
fi

COMMAND="helm history ${CHART} -o json |jq -r '.[] | select(.status==\"failed\") | (\"${CHART}.v\(.revision)\") | @sh'"
RELEASES=$( eval "$COMMAND" )

if [ -z "$RELEASES" ]; then
  echo "No failed releases to patch"
else
  do_patch_process
fi