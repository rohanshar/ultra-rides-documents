#!/bin/bash

# Define the region
REGION="ap-south-1"

# Define the directory for API Gateway documentation
APIGATEWAY_DIRECTORY="./apigateway"

# Create the directory if it doesn't exist
mkdir -p $APIGATEWAY_DIRECTORY

# Clear all files in the directory
rm -f $APIGATEWAY_DIRECTORY/*

# Define the API ID
API_ID="xur3brrsve"

# Output file for API routes
ROUTES_FILE="$APIGATEWAY_DIRECTORY/${API_ID}_routes.json"

# Get the API routes and save to a file
aws apigatewayv2 get-routes --region $REGION --api-id $API_ID --output json > $ROUTES_FILE

if [ $? -eq 0 ]; then
  echo "Routes for API $API_ID saved to $ROUTES_FILE"

  # Create a Markdown file for documenting the API routes
  MD_FILE="$APIGATEWAY_DIRECTORY/${API_ID}_routes.md"

  echo "# API Gateway Routes Documentation" > $MD_FILE
  echo "## API ID: $API_ID" >> $MD_FILE

  # Extract the API routes and document them
  ROUTES=$(jq -r '.Items[] | {routeKey: .RouteKey, target: .Target}' $ROUTES_FILE)
  
  echo "## Routes" >> $MD_FILE
  echo "$ROUTES" | jq -r '. | "- **Route Key**: \(.routeKey)\n  - **Target**: \(.target)\n"' >> $MD_FILE

  echo "API documentation has been saved to $MD_FILE"
else
  echo "Failed to get resources for API $API_ID. Please check the API ID and try again."
fi

echo "API documentation generation completed."