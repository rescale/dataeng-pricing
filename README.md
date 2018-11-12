# Rescale data engineering price pipeline project

*Please do not fork this repo.*

In this project, you are asked to create a simple data pipeline, inserting a JSON-formatted timeseries of compute prices from an AWS S3 bucket into a SQL database.

The following pieces will need to be *done by you*:
1. Provision a SQL DB of your choice
2. Initialize the database with a table to store the prices
3. Deploy a pipeline to read new prices from the S3 bucket and insert them into the SQL DB

The SQL table you create should at least have the following fields:
* account ID (string)
* region (string)
* availability zone (string)
* instance type (string)
* price (float or decimal)
* timestamp (datetime)

You can add additional fields if you like. All of the above data will be available from the file names or file content in the input data.

## Input data

Each day a new set of price dumps is deposited into the bucket: `s3://sample-spot-prices`. All data in the bucket should be publicly available.

The s3 key format is as follows:

`spotprices_<YYYYMMDD>_<account ID>_<region>.json`

Each fileset is for a full day's worth of prices and is generated at approximately 00:01 UTC the following day. To be safe, you can assume all data files will be available by 00:10 UTC. So for example:

[`spotprices_20181030_604329154527_us-west-2.json`](https://s3.amazonaws.com/sample-spot-prices/spotprices_20181030_604329154527_us-west-2.json) represents prices between 2018-10-30T00:00 and 2018-10-30T23:59 UTC and will be available in the bucket by 2018-10-31T00:10 UTC.

## Requirements

* Your pipeline should automatically fetch new data when it becomes available. New prices should be imported into the SQL database in less than 24 hours after they are generated.

* Your solution should be deployed to some public cloud of your choice.

* Try to automate as much of the provisioning as possible to submit as your solution.

* Once you have completed the project, we will set up a call to go through your solution via screenshare. You should either be able to easily re-deploy your solution or you should leave it deployed until you walk through it with us.

* *You should prioritize easy maintenance, simple design, and clean code in your solution. Performance is not a priority here.*

* Your solution should be reasonably secure (e.g. your SQL DB should not be directly accessible from the public internet).

* It it totally fine (and encouraged if it simplifies maintenance and design) to use managed services offered by the cloud of your choice. If you have questions about an appropriate design before implementing, you can email mark@rescale.com.

## Setup

If you decide to implement on a cloud *besides* the "Big 3" (AWS, Azure, GCP), please check with mark@rescale.com before proceeding.

*However, if you choose to implement your solution on AWS, we have provided some terraform scripts to get you started!* These scripts will provide a base VPC in which you can deploy your solution and avoid several pitfalls of deploying AWS networking.

You should fill in the settings in `variables.tf` that are not set and then run the `build.sh` script. This script will provision a VPC with some subnets, an internet gateway, and some routing. It will also setup a bastion host to be accessible from the IP address you set in `variables.tf` for testing and debugging your deployment. The AMI for the bastion host should be publicly accessible but if you want to customize it, we have provided the Packer file (`bastion.json`) used to create it.

Feel free to update other terraform variables if you want to deploy to a different region or if the AZs provided are not available on your own account. Also feel free to update the VPC configuration to suit your needs. If you make changes, please be sure to included the updated terraform scripts in your solution.

We anticipate solutions should fall under cloud providers' "free tier" pricing but if you end up incurring cloud costs for implementing and deploying your solution, let mark@rescale.com know and we will work something out.

## Deliverables

Create a new repo with your GitHub account and send us the link. *Please use a different repo name and do not fork this one.*

Your submission should include:

* Source code and configuration files used in your solution

* Specification of how to deploy your solution (in README.md)

* Discussion of how to update the pipeline code after it has been deployed (also in README.md)

The requirements are intentionally vague so feel free to ask questions along the way. There is no deadline for this but we do ask that you keep track of the amount of time you spend working on this. Target time to complete this is 4 hours.
