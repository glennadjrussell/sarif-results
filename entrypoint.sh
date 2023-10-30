#!/bin/sh -l

formatted=$(cat $1 | jq --raw-output '\n"| SNYK ID | Short description | Full Description |",\n"|---------|------------------|------------------|",\n(.runs[].tool.driver.rules[] | ["|", .id, "|", .shortDescription.text, "|", .fullDescription.text, "|"] | join(" "))\n')

echo "sarif_json=$formatted" >> $GITHUB_OUTPUT

