# hometap_tf_takehome

## Hometap Take-Home Exercise: DevOps Engineer

### Instructions:

Before your interview, we would like you to prepare and submit some code via GitHub /
GitLab that we will review and discuss with you during our scheduled interview time. You’ll
be expected to walk us through your code and explain your decisions, other possible
solutions, and potential improvements. You should also come prepared to talk about
potential CI/CD solutions for testing and deploying a project like this, though no CI/CD code
is required.

### Overview:

At Hometap, we use Terraform to manage most of our cloud infrastructure in AWS. We have
a lot of repositories, modules, and tools to manage this infrastructure. We like Terraform and
use it extensively in our CI/CD process.

Your goal is to demonstrate your understanding of Terraform syntax, module structure, and
variable definition, as well as show your ability to create reusable and maintainable code by
creating a Terraform project that satisfies the criteria below.

It is not required that you deploy this code to AWS prior to submission; we will not be testing
or running this. Validating the project with Terraform should succeed, but runtime or cloud
errors not addressed in this exercise won’t be discussed or taken into account.
Terraform / AWS Infrastructure Setup Deliverables:

Create a Terraform repository that creates the following resources in AWS:

Auto Scaling Group:
- Deploy an Auto Scaling Group using the standard AWS Linux AMI.
- Ensure the ASG scales based on CPU utilization (For example, scale-out when CPU >
70%, and scale-in when CPU < 30%).
- Ensure the security group created for this project is attached to the instances

IAM Policy and Role Creation:
- Create an IAM policy that grants read/write access to a specific S3 bucket.
- Attach this policy to an IAM role.
- Associate this IAM role with the EC2 instances in the ASG, allowing them to interact
with the S3 bucket you will create.

S3 Bucket:
- Create an S3 bucket with appropriate configuration (e.g., versioning, logging).

Security Group:
- Create a security group for the EC2 instances with rules to allow inbound and
outbound traffic on ports 80 & 443.

*At least one of these resource groups should be integrated into your main script as a
separate Terraform module that you create. You will be expected to explain how this
module could be extended and reused.

Questions:

Please reach out to our Recruiting Team if you have any questions regarding the exercise or
expectations!
