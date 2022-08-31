import json
import boto3
import uuid

RAW_PATH = "/SumFunction"

def lambda_handler(event, context):
    
    # Check if endpoint is valid
    if event["rawPath"] == RAW_PATH:
        
        # Extract numbers from event and calculate sum
        num1 = int(event["queryStringParameters"]["num1"])
        num2 = int(event["queryStringParameters"]["num2"])
        sum = num1 + num2
        
        # Publish to SNS Topic
        client = boto3.client("sns")
        response = client.publish(
            TopicArn="arn:aws:sns:us-east-1:179867551207:SumTopic",
            Message=f"Your Numbers: {num1},{num2}. Sum result : {sum}.")
            
        return {
            "num1": num1,
            "num2": num2,
            "Sum result": sum 
        }