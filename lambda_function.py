import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    
    instances = ec2.describe_instances(Filters=[
        {'Name': 'instance-state-name', 'Values': ['running', 'stopped']}
    ])
    
    instance_ids = [
        i['InstanceId'] 
        for r in instances['Reservations'] 
        for i in r['Instances']
    ]
    
    if not instance_ids:
        print("No instances found")
        return
    
    action = event.get("action")  # Get payload "start" or "stop" form EventBridge
    
    if action == "start":
        print("Starting instances: ", instance_ids)
        ec2.start_instances(InstanceIds=instance_ids)
    elif action == "stop":
        print("Stopping instances: ", instance_ids)
        ec2.stop_instances(InstanceIds=instance_ids)
