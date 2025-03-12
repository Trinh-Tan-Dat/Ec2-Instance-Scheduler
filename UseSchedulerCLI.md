# AWS Instance Scheduler Configuration

## Pipeline Architect
![Pipeline Architecture](image.png)
---
Install Schduler CLI
```sh
wget -O instance_scheduler_cli.zip https://s3.amazonaws.com/solutions-reference/instance-scheduler-on-aws/latest/instance_scheduler_cli
.zip

unzip instance_scheduler_cli.zip

pip install --no-index --find-links=instance_scheduler_cli instance_scheduler_cli 
```
---
## Step 1: Create a Period using **Scheduler CLI**
Create new Period with begintime at 10am and endtime at 23h59pm. 

```sh
scheduler-cli create-period --name <"Period Name"> --begintime 10:00 --endtime 23:59 --weekdays mon-fri --stack <Cloudformation Stack Name>
```

## Step 2: Create a Schedule using **Scheduler CLI**
Create a schedule that **references** the period bellow use:
```sh
scheduler-cli create-schedule --name <Schedule Name> --periods <Period Name>,weekends --timezone Asia/Ho_Chi_Minh --stack <Cloudformation Stack Name>
```

## Step 3: Attach to Instances

### Attach Schedule to a EC2 Instance
**Must use AWS CLI (Scheduler CLI dont have commands)**

```sh
aws ec2 create-tags \
    --resources <INSTANCE_ID> \
    --tags Key=Schedule,Value=<Schedule Name> \
    --region <Region>
```

### Attach Schedule to a RDS Instance
```sh
```

### Attach Schedule to a Neptune Instance
```sh
```

### Attach Schedule to a DocumentDB Instance
```sh
```
---
## Learn More About Scheduler CLI Commands visit the
[Scheduler CLI Commands](https://docs.aws.amazon.com/solutions/latest/instance-scheduler-on-aws/scheduler-cli-4.html).