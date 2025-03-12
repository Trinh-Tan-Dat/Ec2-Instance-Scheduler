# AWS Instance Scheduler Configuration

## Overview
AWS Instance Scheduler is a solution that allows you to automate the start and stop times of your EC2 instances using schedules and periods.

### Learn More
For more detailed [AWS Instance Scheduler](https://cloud-alliance.atlassian.net/wiki/spaces/SD/pages/64126978/Reports+for+Instance+Scheduler).
### What is a Period?
A period defines a specific time range within which instances should start/stop. It includes attributes:
- `begintime`: The start time (e.g., `10:00`)
- `endtime`: The end time (e.g., `23:59`)
- `weekdays`: The days of the week when the period applies (e.g., `mon-fri`)
- `timezone`: The timezone in which the period is defined

### What is a Schedule?
A schedule is a set of one or more periods. It associates specific periods with EC2 instances using tags.
- A schedule can reference one or more periods
- The schedule's timezone should match the required execution region

---
## Pipeline Architect
![Pipeline Architecture](image.png)
---
## Step 1: Create a Period using AWS CLI
To create a new period name `custom-hours`, 

Create new Period with begintime at 10am and endtime at 23h59pm. 
Change `table-name` with name of table in dynamoDB

```sh
aws dynamodb put-item \
    --table-name "instance-scheduler-ConfigTable-1UEPV1KC8ZETH" \
    --item '{
        "type": {"S": "period"},
        "name": {"S": "period-1"},
        "begintime": {"S": "10:00"},
        "description": {"S": "Custom working hours"},
        "endtime": {"S": "23:59"},
        "weekdays": {"SS": ["mon", "tue", "wed", "thu", "fri"]}
    }' \
    --region us-east-1
```

---

## Step 2: Create a Schedule using AWS CLI
Create a schedule that **references** the `period-1` period and name for schedule is `schedule-1` , use:

```sh
aws dynamodb put-item \
    --table-name "instance-scheduler-ConfigTable-1UEPV1KC8ZETH" \
    --item '{
        "type": {"S": "schedule"},
        "name": {"S": "schedule-1"},
        "description": {"S": "Custom schedule using custom-hours period"},
        "periods": {"SS": ["custom-hours"]},
        "timezone": {"S": "Asia/Ho_Chi_Minh"}
    }' \
    --region us-east-1
```

---

## Step 3: Assign Schedule to Instances

### Attach Schedule to a EC2 Instance
#### Ataach tags with Key is `Schedule` and value is name of Schedule just created `schedule-1`
```sh
aws ec2 create-tags \
    --resources <INSTANCE_ID> \
    --tags Key=Schedule,Value="schedule-1" \
    --region us-east-1
```
#### After that, Ec2 will implement schedule, start at 10am and end at 23h59
### Attach Schedule to a RDS Instance
```sh
```

### Attach Schedule to a Neptune Instance
```sh
```

### Attach Schedule to a DocumentDB Instance
```sh
```

