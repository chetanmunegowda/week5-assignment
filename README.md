# week5-assignment
Objectives 

Understand how to use the delte and deregister portions of th AWS CLI Understand how to use the wait functions in the AWS CLI Understand how to automate the destruction of AWS artifacts in your environment Learn how to make use of the query and filter options for customizing AWS CLI output Outcomes  At the completeion of this weeks lab and lecture you will have the ability to automate the destruction of artifacts in your AWS environment.  You will have gained experience using query and filter options to modify the output of AWS CLI commands for use in storing and sorting data.  Finally you will have used the wait commands to ensure that all resources have been launched in time -- allowing script completion.  

Deliverable: 

Develop a shell script:  that will do the following 

aws autoscaling detach load-balancers from autoscaling group 

aws autoscaling delete autoscaling configuration 

aws autoscaling delete-launch configuration  

aws elb de register instances from load-balancer 

aws elb delete listeners  

aws elb delete load-balancers

aws ec2 terminate-instances  

Script must use the AWS CLI and take no human input but automate the querying and destruction of your AWS environment (no hard coding of values)  Name the file:  destroy-env.sh
