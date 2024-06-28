{
    "TableName": "ultrarides_rides",
    "KeySchema": [
        {
            "AttributeName": "RideID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "ClubID",
            "KeyType": "RANGE"
        }
    ],
    "AttributeDefinitions": [
        {
            "AttributeName": "ClubID",
            "AttributeType": "S"
        },
        {
            "AttributeName": "RideID",
            "AttributeType": "S"
        }
    ],
    "GlobalSecondaryIndexes": [
        {
            "IndexName": "RideID-index",
            "KeySchema": [
                {
                    "AttributeName": "RideID",
                    "KeyType": "HASH"
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
            "IndexSizeBytes": 840,
            "ItemCount": 3,
            "IndexArn": "arn:aws:dynamodb:ap-south-1:419003463362:table/ultrarides_rides/index/RideID-index"
        }
    ]
}