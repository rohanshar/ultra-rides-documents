#!/bin/bash

# Define the region
REGION="ap-south-1"

# Define the directory
DIRECTORY="./dynamodb"

# Create the directory if it doesn't exist
mkdir -p $DIRECTORY

# Clear all JSON files in the directory
rm -f $DIRECTORY/*.json

# Output file for table list
TABLE_LIST_FILE="$DIRECTORY/dynamodb_tables.json"

# Get the list of tables and save to a file
aws dynamodb list-tables --region $REGION --output json > $TABLE_LIST_FILE

# Extract table names and iterate over them
TABLE_NAMES=$(awk -F\" '/"TableNames"/ {getline; while($0 !~ /\]/) {print $2; getline}}' $TABLE_LIST_FILE)

for TABLE_NAME in $TABLE_NAMES; do
  # Output file for table schema
  SCHEMA_FILE="$DIRECTORY/${TABLE_NAME}_schema.json"
  
  # Get the table description and save to a file
  aws dynamodb describe-table --region $REGION --table-name $TABLE_NAME --output json > $SCHEMA_FILE
  
  echo "Schema for table $TABLE_NAME saved to $SCHEMA_FILE"
done

echo "Schema generation completed."
