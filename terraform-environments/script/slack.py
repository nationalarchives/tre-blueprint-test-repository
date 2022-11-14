import requests
import os

slack_token = os.environ['SLACK_TOKEN']
slack_channel = os.environ['SLACK_CHANNEL']
github_url = os.environ['URL'] 

# Get the plan.out file
def get_file_content(file_name):
    content = ''
    with open(file_name, 'rb') as f:
        content = f.read()
    return content

# Post file with slack 
def send_file():
    content = get_file_content('plan.txt')
    message = f'*Plese review the plan below before approving in <{github_url}|here>*'
    url = "https://slack.com/api/files.upload"
    data = {
        'token': slack_token,
        'channels': slack_channel,
        'initial_comment': message,
        'content': content,
        'filename': 'plan.txt',
        'filetype': 'text',
        'title': 'Terraform Plan',
    }
    res = requests.post(url=url, data=data)
    if res.status_code == 200:
        print(f'OK: {res.json().get("ok")}, Error: {res.json().get("error")}')
    else:
        print(f'Fail to send: {res.json().get("error")}')

send_file()
