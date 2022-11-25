import boto3
import time
import json
import requests
import os

my_session = boto3.session.Session()
my_region = my_session.region_name
client = boto3.client("logs")
timestamp = int(time.time()) * 1000
log_group_name = os.environ['LOG_GROUP_NAME'] 
log_stream_name = os.environ['LOG_STREAM_NAME']
env = os.environ['ENV']
github_url = os.environ['GITHUB_URL'] 
slack_webhook = os.environ['SLACK_WEBHOOK']

# Get the plan.txt file
def get_file_content(file_name):
    log_event = ''
    with open(file_name) as f:
        log_event = [{'timestamp': timestamp, 'message': f.read()}]
    return log_event

# Send terraform plan to CloudWatch for review
def send_to_cloudwatch():
    log_event = get_file_content('plan.txt')
    client.create_log_stream(logGroupName=log_group_name, logStreamName=log_stream_name)
    response = client.put_log_events(logGroupName=log_group_name,
                                    logStreamName=log_stream_name,
                                    logEvents=log_event)
    if response['ResponseMetadata']['HTTPStatusCode'] == 200:
        print("Terraform plan sent to CloudWatch successfully!")
    else:
        print(f"Error: {response['ResponseMetadata']['HTTPStatusCode']}")
send_to_cloudwatch()

def send_message_to_slack():
    # URL for the CloudWatch Log Stream where terraform plan will be sent to. 
    base_url = "https://console.aws.amazon.com/cloudwatch/home?"
    log_group= f"#logsV2:log-groups/log-group/{log_group_name}/"
    log_stream = f"log-events/{log_stream_name}"
    region = f"region={my_region}"
    cloud_watch_url = f"{base_url}{region}{log_group}{log_stream}"

    message = f"Please review <{cloud_watch_url}|terraform plan> for `{env}` in the management account and approve the <{github_url}|workflow>"
    msg = {
    "channel": "tna-test",
    "username": "terraform-plan",
    "text": message
    }

    encoded_msg = json.dumps(msg, indent=2).encode("utf-8")
    resp = requests.post(slack_webhook, data=encoded_msg)
    if resp.status_code == 200:
        print("A message sent to slack with links to CloudWatch Log Stream for terraform plan and GitHub Workflow")
    else:
        print(f"Error: {resp.status_code}")
send_message_to_slack()