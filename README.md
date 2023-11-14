# sarif-results docker action

Takes a JSON input of Snyk scan results and outputs a markdown formatted representation of that JSON.

## Inputs

## `json`

**Required** JSON file conforming to the Sarif schema

## Outputs

## `sarif_json`

The formatted markdown


## `status`

A status message on results found

## Example usage

uses: qarik-snyk/scan-resuits@v2
with:
  json: snyk.sarif

