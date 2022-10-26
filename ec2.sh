# create public route table
aws ec2 create-route-table \
    --vpc-id "vpc-088ec956294cef3a5" \
    --region "us-west-1" \
    --query "RouteTable.RouteTableId" \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=Jenkins-Pub-rt}]" 

# create private route table
aws ec2 create-route-table \
    --vpc-id "vpc-088ec956294cef3a5" \
    --region "us-west-1" \
    --query "RouteTable.RouteTableId" \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=Jenkins-Pvt-rt}]"
