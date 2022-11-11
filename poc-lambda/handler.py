"""
Example AWS Lambda handler function.
"""
def handler(event, context):
    print(f'event={event}')
    print(f'context={context}')

    return {
        'alpha': {
            'bravo': 2
        },
        'charlie': ['delta', 'echo']
    }
