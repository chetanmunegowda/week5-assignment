#!/bin/bash

securityGroupName=`aws ec2 describe-security-groups --query 'SecurityGroups[*].GroupId'`

instances=`aws ec2 describe-instances --query 'Reservations[*].Instances[].InstanceId'`

loadBalancer=`aws elb describe-load-balancers --query LoadBalancerDescriptions[*].LoadBalancerName`

launchConfiguration=`aws autoscaling describe-launch-configurations --query LaunchConfigurations[*].LaunchConfigurationName`

autoScalingGroupName=`aws autoscaling describe-auto-scaling-groups --query AutoScalingGroups[*].AutoScalingGroupName`

echo "Security Group Name "$securityGroupName
echo "Running Istances "$instances
echo "Load Balancer "$loadBalancer
echo "Launch Configuration "$launchConfiguration
echo "Auto Scaling Group Name "$autoScalingGroupName
echo "-----------------------------------------------------------------------------------"

echo "declaration and assignment of variables required for further operation"
count=0
port_number=80
echo "declaration and assignment done!"

echo "setting the auto scaling group desired capacity to zero"
aws autoscaling update-auto-scaling-group --auto-scaling-group-name $autoScalingGroupName --launch-configuration-name $launchConfiguration --min-size $count --max-size $count --desired-capacity $count
echo "successfully set to 0!"
echo "-----------------------------------------------------------------------------------"

echo "detaching auto scaling group from load balancer"
aws autoscaling detach-load-balancers --load-balancer-names $loadBalancer --auto-scaling-group-name $autoScalingGroupName
echo "successfully detached auto scaling group from load balancer!"
echo "------------------------------------------------------------------------------------"

echo "deleting auto scaling group"
aws autoscaling delete-auto-scaling-group --auto-scaling-group-name $autoScalingGroupName
echo "successfully deleted auto scaling group!"
echo "------------------------------------------------------------------------------------"

echo "deleting launch configuration"
aws autoscaling delete-launch-configuration --launch-configuration-name $launchConfiguration
echo "successfully deleted launch configuration group!"
echo "------------------------------------------------------------------------------------"

echo "deregistering instances from load balancer"
aws elb deregister-instances-from-load-balancer --load-balancer-name $loadBalancer --instances $instances
echo "successfully deregistered instances from load balancer!"
echo "------------------------------------------------------------------------------------"

echo "deleting load balancer listeners from Port Number 80"
aws elb delete-load-balancer-listeners --load-balancer-name $loadBalancer --load-balancer-ports $port_number
echo "successfully deleted load balancer listeners from port number 80!"
echo "------------------------------------------------------------------------------------"

echo "deleting the load balancer"
aws elb delete-load-balancer --load-balancer-name $loadBalancer
echo "successfully deleted the load balancer!"
echo "------------------------------------------------------------------------------------"

echo "Finally terminating instances"
aws ec2 terminate-instances --instance-ids $instances
echo "waiting for instances to be closed"
aws ec2 wait instance-terminated --instance-ids $instances
echo "successfully terminated the instances!"
echo "------------------------------------------------------------------------------------"
