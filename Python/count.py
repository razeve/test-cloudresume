import json
import boto3 

dynamodb = boto3.resource('dynamodb')
table_name = 'count_table'
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    # Read from DynamoDB
    response = table.get_item(
        Key={
            'id': 'visit-record'
        }
    )
    item = response.get('Item', {})

    # Update DynamoDB
    item['visit'] = item.get('visit', 0) + 1
    table.update_item(
        Key={
            'id': 'visit-record'
        },
        UpdateExpression='SET visit = :visit',
        ExpressionAttributeValues={
            ':visit': item['visit']
        }
    )

    # Prepare response body with updated visit count
    response_body = {
        "message": f"Visited {item['visit']} times."
    }

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token"
        },
        "body": json.dumps(response_body)  # Convert dictionary to JSON string
    }
