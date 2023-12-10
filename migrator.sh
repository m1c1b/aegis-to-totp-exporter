#!/bin/bash

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --namespace)
      namespace="$2"
      shift
      ;;
    --json-in)
      json_file="$2"
      shift
      ;;
    *)
      echo "Unknown parameter passed: $1"
      exit 1
      ;;
  esac
  shift
done

# Check if --namespace parameter is provided
if [ -z "$namespace" ]; then
  echo "Please provide a namespace using the --namespace parameter."
  exit 1
fi

# Check if --json-in parameter is provided
if [ -z "$json_file" ]; then
  echo "Please provide input JSON file name using the --json-in parameter."
  exit 1
fi

# Read JSON content from file
json_input=$(cat "$json_file")

# Use jq to convert JSON to YAML
yaml_content=$(echo "$json_input" | jq -r --arg ns "$namespace" '
  [{
    name: $ns,
    accounts: [.db.entries[] | {
      name: "\(.issuer) \(.name)",
      token: .info.secret
    }]
  }]' | yq eval -P)

# Remove single quotes from name in accounts
yaml_content=$(echo "$yaml_content" | sed "s/'//g")

# Print the result
echo "$yaml_content" > output.yml

echo "YAML file generated: output.yml"
