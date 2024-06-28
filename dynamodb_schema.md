
# list of tables 
aws dynamodb list-tables --query "TableNames[]" --output text

ultrarides_RiderRides   ultrarides_clubs        ultrarides_rides

#table schema
for table in $(aws dynamodb list-tables --query "TableNames[]" --output text); do
    aws dynamodb describe-table --table-name $table --query "Table.{TableName:TableName, KeySchema:KeySchema, AttributeDefinitions:AttributeDefinitions, GlobalSecondaryIndexes:GlobalSecondaryIndexes}" --output json
done

{
    "TableName": "ultrarides_RiderRides",    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
:...skipping...
{
    "TableName": "ultrarides_RiderRides",
    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "RideID",
            "AttributeType": "S"
:...skipping...
{
    "TableName": "ultrarides_RiderRides",
    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
        },
:...skipping...
{
    "TableName": "ultrarides_RiderRides",
    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "RideID",
            "AttributeType": "S"
        },
        {
            "AttributeName": "RiderID",
            "AttributeType": "S"
        }
    ],
    "GlobalSecondaryIndexes": [
        {
            "IndexName": "RideIDIndex",
:...skipping...
:...skipping...
{
    "TableName": "ultrarides_RiderRides",
    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "RideID",
            "AttributeType": "S"
        },
        {
            "AttributeName": "RiderID",
            "AttributeType": "S"
        }
    ],
    "GlobalSecondaryIndexes": [
        {
            "IndexName": "RideIDIndex",
            "KeySchema": [
                {
:...skipping...
                {
:...skipping...
{
    "TableName": "ultrarides_RiderRides",
    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "RideID",
            "AttributeType": "S"
        },
        {
            "AttributeName": "RiderID",
            "AttributeType": "S"
        }
    ],
    "GlobalSecondaryIndexes": [
        {
            "IndexName": "RideIDIndex",
            "KeySchema": [
                {
                    "AttributeName": "RideID",
:...skipping...
:...skipping...
{
    "TableName": "ultrarides_RiderRides",
    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "RideID",
            "AttributeType": "S"
        },
        {
            "AttributeName": "RiderID",
            "AttributeType": "S"
        }
    ],
    "GlobalSecondaryIndexes": [
        {
            "IndexName": "RideIDIndex",
            "KeySchema": [
                {
                    "AttributeName": "RideID",
                    "KeyType": "HASH"
                },
:...skipping...
{
    "TableName": "ultrarides_RiderRides",
    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "RideID",
            "AttributeType": "S"
        },
        {
            "AttributeName": "RiderID",
            "AttributeType": "S"
        }
    ],
    "GlobalSecondaryIndexes": [
        {
            "IndexName": "RideIDIndex",
            "KeySchema": [
                {
                    "AttributeName": "RideID",
                    "KeyType": "HASH"
                },
                {
:...skipping...
:...skipping...
{
    "TableName": "ultrarides_RiderRides",
    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "RideID",
            "AttributeType": "S"
        },
        {
            "AttributeName": "RiderID",
            "AttributeType": "S"
        }
    ],
    "GlobalSecondaryIndexes": [
        {
            "IndexName": "RideIDIndex",
            "KeySchema": [
                {
                    "AttributeName": "RideID",
                    "KeyType": "HASH"
                },
                {
                    "AttributeName": "RiderID",
:...skipping...
{
{
    "TableName": "ultrarides_RiderRides",
    "KeySchema": [
        {
            "AttributeName": "RiderID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "RideID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "RideID",
            "AttributeType": "S"
        },
        {
            "AttributeName": "RiderID",
            "AttributeType": "S"
        }
    ],
      "GlobalSecondaryIndexes": [
        {
            "IndexName": "RideIDIndex",
            "KeySchema": [
                {
                    "AttributeName": "RideID",
                    "KeyType": "HASH"
                },
                {
                    "AttributeName": "RiderID",
                    "KeyType": "RANGE"
                }
            ],
            "Projection": {
                "ProjectionType": "ALL"
            },
            "IndexStatus": "ACTIVE",
            "ProvisionedThroughput": {
                "NumberOfDecreasesToday": 0,
                "ReadCapacityUnits": 1,
                "WriteCapacityUnits": 1
            },
            "IndexSizeBytes": 110,
            "ItemCount": 1,
            "IndexArn": "arn:aws:dynamodb:ap-south-1:419003463362:table/ultrarides_RiderRides/index/RideIDIndex"
        }
    ]