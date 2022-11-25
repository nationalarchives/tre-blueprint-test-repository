import boto3
import time
import json
import requests
import os
import sys

my_session = boto3.session.Session()
my_region = my_session.region_name
client = boto3.client("logs")
timestamp = int(time.time()) * 1000
log_group_name = os.environ['LOG_GROUP_NAME'] 
log_stream_name = os.environ['LOG_STREAM_NAME']
file_name = sys.argv[1]
if file_name == 'error.txt':
    log_group_name = "github-actions-error"
# Get the plan.txt file

def get_file_content(file_name):
    log_event = ''
    with open(file_name) as f:
        log_event = [{'timestamp': timestamp, 'message': f.read()}]
    return log_event

# Send terraform plan to CloudWatch for review
def send_to_cloudwatch():
    log_event = get_file_content(file_name)
    client.create_log_stream(logGroupName=log_group_name, logStreamName=log_stream_name)
    response = client.put_log_events(logGroupName=log_group_name,
                                    logStreamName=log_stream_name,
                                    logEvents=log_event)
    if response['ResponseMetadata']['HTTPStatusCode'] == 200:
        print("Terraform plan sent to CloudWatch successfully!")
    else:
        print(f"Error: {response['ResponseMetadata']['HTTPStatusCode']}")
send_to_cloudwatch()