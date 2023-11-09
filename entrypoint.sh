#!/bin/sh -l

case "$1" in
  sca)
    formatted=$(cat "$2" | jq --raw-output '"| SNYK ID | Short description | Full Description |","|---------|------------------|------------------|",(.runs[].tool.driver.rules[] | ["|", .id, "|", .shortDescription.text, "|", .fullDescription.text, "|"] | join(" "))')
    ;;
  code)
    formatted=$(cat "$2" | jq --raw-output '"| SNYK Rule ID | Source file | Line |","|---------|------------------|------------------|",(.runs[].results[] | ["|", .ruleId, "|", .locations[].physicalLocation.artifactLocation.uri, "|", .locations[].physicalLocation.region.startLine, "|"] | join(" "))')
    ;;
  *)
    exit 1
esac

echo "sarif_json<<EOF" >> $GITHUB_OUTPUT
echo "$formatted" >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT

exit 0

