# AWS Lambda EC2 Scheduler

## Description
Instance Scheduler for all EC2 instances to automatically start at 10am and stop after 12pm.

---
## Architect Topology
![Architect Topology](image.png)
---
## Step 1: Deploy AWS Lambda

### 1.1. Create Lambda Function

1. Create new function from dashboard
2. Paste the code from `lambda_function.py`
3. Lambda will get payload from EventBridge. If the value of payload is `start`, this function will apply for all ec2.

---
## Step 2: Create EventBridge Rules

### 2.1. Rule to Start All EC2 (10am)
This rule will trigger lambda function and send payload at 10am.

1. Schedule pattern: `Cron expression`
   ```
   0 10 * * ? *  // (minutes / hours /day of months / month / day of weeks / year)
   ```
2. Select Target: `AWS Lambda function`
3. Add Payload:
   ```json
   {
     "action": "start"
   }
   ```

### 2.2. Rule to Stop EC2 (12 PM UTC)
This rule will trigger lambda function and send payload at 10am.

#### Repeat the above steps but change:
- Cron expression:
  ```
  0 12 * * ? *
  ```
- Payload:
  ```json
  {
    "action": "stop"
  }
  ```

---
### Document
https://repost.aws/knowledge-center/start-stop-lambda-eventbridge