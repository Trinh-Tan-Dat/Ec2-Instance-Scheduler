// Base on Ec2 ID

aws ec2 create-tags \
    --resources i-030d14090a3734755 \
    --tags Key=Schedule,Value="custom-schedule" \
    --region us-east-1


