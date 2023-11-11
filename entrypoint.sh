#!/bin/sh -l

case "$1" in
  sca)
    results=$(cat "$2" | jq '.runs[].tool.driver.rules[]')
    if [ -z "$results" ]; then
      status="\u2705 No SCA issues reported"
      echo "status=$status'" >> $GITHUB_OUTPUT
      formatted="$status"
    else
      echo "status='\u274C SCA issues reported'" >> $GITHUB_OUTPUT
      formatted=$(cat "$2" | jq --raw-output '"| SNYK ID | Short description | Full Description |","|---------|------------------|------------------|",( .runs[].tool.driver.rules[] | ["|", .id, "|", .shortDescription.text, "|", .fullDescription.text, "|"] | join(" "))')
    fi
    ;;
  code)
    results=$(cat "$2" | jq '.runs[].results[]')
    if [ -z "$results" ]; then
      status="\u2705 No code issues reported"
      formatted="$status"
      echo "status=$status" >> $GITHUB_OUTPUT
    else
      echo "status='\u274C code issues reported'" >> $GITHUB_OUTPUT
      formatted=$(cat "$2" | jq --raw-output '"| SNYK ID | Short description | Full Description |","|---------|------------------|------------------|",(.runs[].results[] | ["|", .ruleId, "|", .locations[].physicalLocation.artifactLocation.uri, "|", .locations[].physicalLocation.region.startLine, "|"] | join(" "))')
    fi
    ;;
  *)
    exit 1
esac

echo "sarif_json<<EOF" >> $GITHUB_OUTPUT
echo "<details>" >> $GITHUB_OUTPUT
echo "<summary>" >> $GITHUB_OUTPUT
echo "Results" >> $GITHUB_OUTPUT
echo "</summary>" >> $GITHUB_OUTPUT
echo "" >> $GITHUB_OUTPUT
echo "$formatted" >> $GITHUB_OUTPUT
echo "" >> $GITHUB_OUTPUT
echo "</details>" >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT

exit 0

