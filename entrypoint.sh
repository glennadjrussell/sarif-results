#!/bin/sh -l

formatted=$(cat snyk.sarif | jq --raw-output '"| SNYK ID | Short description | Full Description |","|---------|------------------|------------------|",(.runs[].tool.driver.rules[] | ["|", .id, "|", .shortDescription.text, "|", .fullDescription.text, "|"] | join(" "))')

echo "sarif_json=$formatted" >> $GITHUB_OUTPUT

