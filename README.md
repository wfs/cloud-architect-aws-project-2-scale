# Design for Performance and Scalability in AWS

---

## Project 2 of 3 in AWS Cloud Architect Nanodegree at Udacity

---

### Part 1 - Design Infrastructure Solution

#### 1.1. Criteria

- Develop a schematic for the application development project.

#### Meets Specification

- The infrastructure includes:

  - Infrastructure in the following regions: us-east-1
  - Users and Client machines
  - One VPC
  - Two Availability Zones
  - Four Subnets (2 Public, 2 Private)
  - A NAT Gateway
  - A CloudFront distribution with an S3 Bucket
  - Web servers in the Public Subnets
  - Application Servers in the Private Subnets
  - DB Servers in the Private Subnets
  - Web Servers Load Balanced and Autoscaled
  - Application Servers Load Balanced and Autoscaled
  - A Master DB in AZ 1 with a read replica in AZ2

- All services in the diagram include a label to indicate the type of service and any necessary parameters (e.g. size, location).

- Visible lines represent all network connections.
  - ![Udacity_Diagram_1](Udacity_Diagram_1.png)

#### 1.2. Criteria

- Develop a schematic for a Serverless AWS infrastructure application development project.

#### Meets Specification

- The infrastructure includes:

  - A user and client machine
  - AWS Route 53
  - A CloudFront Distribution
  - AWS Cognito
  - AWS Lambda
  - API Gateway
  - DynamoDB
  - S3 Storage

- All services in the diagram include a label to indicate the type of service and any necessary parameters (e.g. size, location).

- Visible lines represent all network connections.
  - ![Udacity_Diagram_2](Udacity_Diagram_2.png)

---

### Part 2 - Estimate Costs

#### 2.1. Criteria

- Estimate the monthly cost of the planned infrastructure for Diagram 1.

#### Meets Specification

- The monthly cost is between $8,000-10,000 using the [AWS Pricing Calculator](https://calculator.aws/#/).

  - [Initial_Cost_Estimate](Initial_Cost_Estimate.csv)

#### 2.2. Criteria

- Modify the infrastructure to reduce the monthly cost.

#### Meets Specification

- The infrastructure includes all required services to run properly.

- The monthly cost is $6,500 or below using the [AWS Pricing Calculator](https://calculator.aws/#/).

  - [Reduced_Cost_Estimate](Reduced_Cost_Estimate.csv)

- A rationale is provided to explain which services were changed or removed.

  - I reduced the size of both the Main RDS MySQL and the Replica RDS MySQL instances.

#### 2.3. Criteria

- Modify the infrastructure to increase performance and redundancy.

#### Meets Specification

- Infrastructure has been re-designed for increased performance and redundancy.

- The monthly cost is between $18,000-20,000 using the [AWS Pricing Calculator](https://calculator.aws/#/).

  - [Increased_Cost_Estimate](Increased_Cost_Estimate.csv)

- A rationale is provided to explain which services were changed or removed.

  - I increased the size of both the Main RDS MySQL and the Replica RDS MySQL instances and added ElastiCache to increase the performance of the web applications.

---

### Part 3 - Infrastructure as Code with Terraform

#### 3.1. Exercise 1 - Criteria

- Provision AWS Infrastructure as Code with Terraform.

#### Meets Specification

- AWS Console EC2 screenshot Terraform_1_1 shows:

  - 4 AWS t2.micro EC2 instances named Udacity T2
  - 2 m4.large EC2 instances named "Udacity M4"

    ```bash
    /Exercise_1/
    $ terraform init
    $ terraform plan
    $ terraform plan -no-color > terraform_plan_no-color.txt
    $ terraform apply
    ```

  - ![Terraform_1_1](./Exercise_1/Terraform_1_1.png)

- Updated AWS Console EC2 screenshot Terraform_1_2 shows:

  - 4 AWS t2.micro EC2 instances named "Udacity T2"

    ```bash
    $ terraform destroy -target=aws_instance.Udacity_M4
    ```

  - ![Terraform_1_2](./Exercise_1/Terraform_1_2.png)

#### 3.2. Exercise 2 - Criteria

- Deploy an AWS Lambda function using Terraform.

#### Meets Specification

- Infrastructure includes:

  - A [lambda.py](./Exercise_2/lambda.py) file
  - A [main.tf](./Exercise_2/main.tf) file
  - An [outputs.tf](./Exercise_2/outputs.tf) file
  - A [variables.tf](./Exercise_2/variables.tf) file

  - Here is a Terraform graph of the current execution plan.

    ```bash
      $ terraform graph | dot -Tsvg > graph.svg
    ```

    - ![graph](./Exercise_2/graph.svg)

- AWS CloudWatch log screenshot Terraform_2_3 shows the CloudWatch log entry that correlates to the lambda function'

  ```bash
  /Exercise_2/
  $ terraform init
  $ terraform plan
  $ terraform plan -no-color > terraform_plan_no-color.txt
  $ terraform apply
  ```

  - ![test](./Exercise_2/test.png)
  - ![Terraform_2_3](./Exercise_2/Terraform_2_3.png)

#### 3.3. Criteria

- Delete and Destroy AWS Infrastructure Resources with Terraform.
- Take a screenshot of the EC2 instances page and label it Terraform_destroyed.png or Terraform_destroyed.jpg.

#### Meets Specification

- All infrastructure provisioned with Terraform is deleted/ destroyed using the \*.tf configuration files.

  ```bash
  $ terraform destroy
  ```

- Terraform destroyed.
  - ![terraform_destroyed](./Exercise_2/terraform_destroyed.png)

---

#### 1.3. [OPTIONAL] Task 3: Configure Permissions.

Attempt this task only if you are using your personal AWS account. This task will not be graded.

In order to complete this task, please ensure your IAM users have been granted access to the billing dashboard (Activating Access to the Billing and Cost Management Console).

1.3.1. Update the AWS password policy.

- Minimum password length = 8
- Require at least one uppercase letter
- Require at least one lowercase letter
- Require at least one number
- Require at least one non-alphanumeric character.
- Submit a screenshot of the Password Policy from the IAM Account settings page. Name the screenshot udacity_password_policy.png or udacity_password_policy.jpg.

  - ![udacity_password_policy](udacity_password_policy.png)

AWS Password Policy

- Example AWS Password Policy

  - 1.3.2. Create a Group named CloudTrailAdmins and give it the two CloudTrail privileges.

  - ![CloudTrailAdmins_group_1](CloudTrailAdmins_group_1.png)
  - ![CloudTrailAdmins_group_2](CloudTrailAdmins_group_2.png)

  - 1.3.3. Create a Group named Reviewers and give it the Billing privilege.

  - ![Reviewers_group_1](Reviewers_group_1.png)
  - ![Reviewers_group_2](Reviewers_group_2.png)

  - 1.3.4. Configure a user named CloudTrail and a user named Accountant. Give the users AWS Console access and assign them a password that conforms to your password policy. Require them to change their password when they login.

  - 1.3.5. Assign CloudTrail to the CloudTrailAdmins group. Assign Accountant to the Reviewers group.

  - ![CloudTrail_user](CloudTrail_user.png)
  - ![Accountant_user](Accountant_user.png)

  - 1.3.6. Test both user accounts by logging into the AWS console as the users CloudTrail and Accountant after changing their passwords on login. Login using your numerical AccountID

  - ![CloudTrail_console_logged_in](CloudTrail_console_logged_in.png)
  - ![Accountant_console_logged_in](Accountant_console_logged_in.png)

  - 1.3.7. While logged-in as the user CloudTrail, go to the CloudTrail page and create a trail named Udacity_Trail. Enable logging on all Read/Writes Management Events and S3 and Lambda events Data Events. Create a new S3 Bucket to store the CloudTrail log. There is no need for advanced configuration.

    - ![Udacity_Trail](Udacity_Trail.png)

  - 1.3.8. Download the portion of the CloudTrail log that shows the entire Task 3 timeframe and save it as UdacityCloudTrailLog.csv.

    - [UdacityCloudTrailLog](UdacityCloudTrailLog.json)

  - 1.3.9. Before Logging off, return to the CloudTrail configuration page. Disable S3 logging.

    - ![Udacity_Trail_logging_to_s3_stopped](Udacity_Trail_logging_to_s3_stopped.png)

#### 1.4. [OPTIONAL ]Task 4: Set up Cost Monitoring

Attempt this task only if you are using your personal AWS account. This task will not be graded.

1.4.1. Configure CloudWatch billing alarm

1.4.2. Set up a Billing alarm with a $5 threshold

- 1.4.2.1. Create budget estimated cost SNS Topic in us-east-1 region aka 'global' billing region.

  - ![sns_topic_budget](sns_topic_budget.png)

- 1.4.2.2. Subscribe to budget SNS topic.

  - ![sns_subscribe_to_budget_topic_1](sns_subscribe_to_budget_topic_1.png)
  - ![sns_subscribe_to_budget_topic_2](sns_subscribe_to_budget_topic_2.png)

- 1.4.3. Set up notification so that you get an email alert when the alarm is triggered.
  Save a screenshot of the CloudWatch Alarms page showing the new alarm with a green OK status as CloudWatch_alarm.png or CloudWatch_alarm.jpg

  - 1.4.1.3. Create CloudWatch billing alarm.

  - ![CloudWatch_alarm_1](CloudWatch_alarm_1.png)
  - ![CloudWatch_alarm_2](CloudWatch_alarm_2.png)

---
