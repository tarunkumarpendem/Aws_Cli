aws ec2 create-route \
    --route-table-id "rtb-0921acd3a9469b955" \
    --destination-cidr-block "0.0.0.0/0" \
    --region "us-east-1" \
    --gateway-id "igw-09379178181ddbd46"
