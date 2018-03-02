# Amazon Web Services Deployment

Amazon Web Services deployment is driven by [Terraform](https://terraform.io/), [Ansible](https://www.ansible.com/), and the [AWS Command Line Interface (CLI)](http://aws.amazon.com/cli/).

## Table of Contents

* [AWS Credentials](#aws-credentials)
* [Deployment](#deployment)
    * [Pre-Deployment Configuration](#pre-deployment-configuration)
    * [SSH Keys](#ssh-keys)
    * [DB_SETTINGS_BUCKET](#db_settings_bucket)
    * [User Data](#user-data)
    * [`scripts/infra`](#scriptsinfra)
    * [Loading Shapefile data](#loading-shapefile-data)


## AWS Credentials
Using the AWS CLI, create an AWS profile named `district-builder`:

```bash
$ vagrant ssh
vagrant@vagrant-ubuntu-trusty-64:~$ aws --profile district-builder configure
AWS Access Key ID [****************F2DQ]:
AWS Secret Access Key [****************TLJ/]:
Default region name [us-east-1]: us-east-1
Default output format [None]:
```

You will be prompted to enter your AWS credentials, along with a default region. These credentials will be used to authenticate calls to the AWS API when using Terraform and the AWS CLI.

## Deployment

### Pre Deployment Configuration

#### SSH Keys

You'll also need to generate an SSH Keypair using the AWS EC2 console. Download the private key, and store it at `~/.ssh/district-builder.pem`.

#### DB_SETTINGS_BUCKET

Before running `scripts/infra`, create an AWS S3 bucket to house the terraform remote state and configuration file. Make note of the bucket name, it will be the value of the `DB_SETTINGS_BUCKET` environment variable later on.

You'll also need to create a `terraform.tfvars` file, which contains the configuration parameters for your infrastructure and application. You can see the available configuration options in [`sample.tfvars`](./terraform/sample.tfvars). Modify this file to suit your needs, and store it on S3 at `s3://${DB_SETTINGS_BUCKET}/terraform/terraform.tfvars`. Note that Application server configuration such as admin usernames and passwords are prefied with `districtbuilder_` (i.e. `districtbuilder_admin_user`).

#### User Data

You can also upload your own DistrictBuilder `config.xml` (optional) and shapefile zip (required) to the App server as a part of provisioning. Simply add a DistrictBuilder `config.xml` file and `districtbuilder_data.zip` in the [`user-data`](./user-data/) folder, and the provisioner will upload them to the server for you. 


#### `scripts/infra`
Once the settings ucket and User Data are configured, you can run the deployment. To deploy the DistrictBuilder core services (VPC, EC2, RDS, etc.) resources, use the `infra` wrapper script to lookup the remote state of the infrastructure and assemble a plan for work to be done:

```bash
$ export DB_SETTINGS_BUCKET="districtbuilder-staging-config-us-east-1"
vagrant@vagrant-ubuntu-trusty-64:~$ export AWS_PROFILE="district-builder"
vagrant@vagrant-ubuntu-trusty-64:~$ export TRAVIS_COMMIT=123456"
vagrant@vagrant-ubuntu-trusty-64:~$ ./scripts/infra plan
```

Once the plan has been assembled, and you agree with the changes, apply it:

```bash
vagrant@vagrant-ubuntu-trusty-64:~$ ./scripts/infra apply
```

This will attempt to apply the infrastructure plan assembled in the previous step using Amazon's APIs, run Ansible to configure the App server with User Data, and run migrations. In order to change specific attributes of the infrastructure, inspect the contents of the environment's configuration file in Amazon S3.

#### Loading Shapefile data
To load data, ssh into the App Server through the bastion, and run `/opt/district-builder/scripts/load_configured_data`.

```bash
# start ssh-agent, and add your ssh private key
$ eval $(ssh-agent)
$ ssh-add ~/.ssh/district-builder.pem

# SSH into the bastion host
$ ssh -A ubuntu@bastion.example.com

# SSh into the app-server from the bastion
ubuntu@bastion.example.com $ ssh ec2-user@app-server.internal.example.com

# Run scripts
$ ec2-user@app-server $ cd /opt/district-builder
$ ec2-user@app-server:/opt/district-builder $ ./scripts/load_configured_data
```