aws dynamodb put-item \
                        --table-name "instance-scheduler-ConfigTable-1UEPV1KC8ZETH" \
                        --item '{
                        "type": {"S": "period"},
                        "name": {"S": "custom-hours"},
                        "begintime": {"S": "09:00"},
                        "description": {"S": "Custom working hours"},
                        "endtime": {"S": "18:00"},
                        "weekdays": {"SS": ["mon", "tue", "wed", "thu", "fri"]}
                    }' \
                        --region us-east-1