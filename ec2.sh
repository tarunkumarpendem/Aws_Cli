# create public route table
aws ec2 create-route-table \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --region "us-east-1" \
    --query "RouteTable.RouteTableId" \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=Jenkins-Pub-rt}]" 

# create private route table
aws ec2 create-route-table \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --region "us-east-1" \
    --query "RouteTable.RouteTableId" \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=Jenkins-Pvt-rt}]"
