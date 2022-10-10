# GitLab_Project
Requirement : Create a new GitLab repository that contains Terraform configuration for deploying the infrastructure to support hosting an application on Linux VMs using AWS or GCP (your choice)
Infra Requirements:

The infrastructure must be deployed using IaC inside of an AWS or GCP virtual private cloud (VPC) with appropriate routing and subnets.
The application must be set up to be public facing using a load balancer. Keep in mind that the application server(s) should not have a public IP.
The application will use a managed Postgres database.
This application will need an object storage bucket.
Add a managed Kubernetes (K8s) cluster (EKS or GKE) to the environment.

Infrastructure Setup: 
1. Setup AWS ClI with key credentials and Terraform setup in local machine.
2. Create VPC:
    1. Create a VPC with public and private subnets in 3 availability zones in a region to ensure HA setup.
    2. Create Internet gateway to enable internet access to the EC2 instance
    3. Create other deployable elements like Route tables, Security groups in the VPC to which instances will belong to.
    
3. Create RDS Postgres instance for application backend.
    1. Create subnets in each availability zone , each with addressblocks within the VPC. 
    2. Create DB subnet group to attach with RDS instance.
    3. Create DB subnet group that will be applied to RDS instance.
    4. Create RDS security group inside the VPC.
    5. Create RDS Postgres database instance which includes DB subnet group and security group.
    
4. Create Application Load Balancer
    1. Create ALB security group.
    2. Create a new ALB.
    3. Create a target group for ALB and define health checks for the target group.
    4. Create load balancer listeners to listen Http client connections.
    
6. Create Application server EC2 instances
    1. Create  new key pair to SSH into EC2 instances.
    2. Create a new EC2 launch configuration,
    3. Create an auto scaling group with a minimum of 3 EC2 instances.
    4. Add new ingress rules to the default security group.
    5. Ec2 instances are created with user supplied AMI's in 3 availability zones.
    
7. Create S3 object managed store for application access.
    1. Create IAM role with inline policy to assume S3 access.
    2. Create IAM role policy and attach to S3 access role. 
    3. Create instance profile for S3 access role that will be passed with E2 instances when they are instantiated.

8. Create EKS cluster
    1. Create IAM role and policy attachments for EKS API server.
    2. Create EKS cluster, node group and ensure IAM roles are created before this process.


To be done in future :
1. Deploy a user aapplication script into the EC2 instances during start up.
