aws dynamodb put-item \
                        --table-name "instance-scheduler-ConfigTable-1UEPV1KC8ZETH" \
                        --item '{
                        "type": {"S": "schedule"},
                        "name": {"S": "custom-schedule"},
                        "description": {"S": "Custom schedule using custom-hours period"},
                        "periods": {"SS": ["custom-hours"]},
                        "timezone": {"S": "Asia/Ho_Chi_Minh"}
                    }' \
                        --region us-east-1