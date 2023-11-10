#!/bin/sh -l

case "$1" in
  sca)
    results=$(cat "$2" | jq '.runs[].results[]')
    if [ -z "$results" ]; then
      formatted="\u2705 No SCA issues reported"
    else
      formatted=$(cat "$2" | jq --raw-output '"| SNYK ID | Short description | Full Description |","|---------|------------------|------------------|",( .runs[].results[], ["|", .id, "|", .shortDescription.text, "|", .fullDescription.text, "|"] | join(" "))')
    fi
    ;;
  code)
    results=$(cat "$2" | jq '.runs[].results[]')
    if [ -z "$results" ]; then
      formatted="\u2705 No SCA issues reported"
    else
      formatted=$(cat "$2" | jq --raw-output '"| SNYK ID | Short description | Full Description |","|---------|------------------|------------------|",(.runs[].results[] | ["|", .ruleId, "|", .locations[].physicalLocation.artifactLocation.uri, "|", .locations[].physicalLocation.region.startLine, "|"] | join(" "))')
    fi
    ;;
  *)
    exit 1
esac

echo "sarif_json<<EOF" >> $GITHUB_OUTPUT
echo "$formatted" >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT

exit 0
