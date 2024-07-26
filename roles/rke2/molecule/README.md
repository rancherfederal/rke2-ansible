# Molecule Scenarios    
| Scenario    | Passing |
| ----------- | ------- |
| rocky-89    | False   |
| rocky-94    | True    | 
| ubuntu-2404 | True    |
| ubuntu-2204 | True    |
| sles-15     | False   |
  
## template  
As the name would imply this is a template scenario, no one is supposed to run this and it will not ever work. The purpose is to prevent other scenarios from having to rewrite or copy from one another, this also allows changes to be shared across all scenarios that are descendants of the template.

## rocky-94
The rocky-94 scenario is the simplest possible scenario, with a single Rocky 9.4 master node and a single Rocky 9.4 worker node. 

## rocky-89
The rocky-89 scenario is the simplest possible scenario, with a single Rocky 8.9 master node and a single Rocky 8.9 worker node. 

## ubuntu-2404
The ubuntu-2204 scenario is the simplest possible scenario, with a single Ubuntu 24.04 master node and a single Ubuntu 24.04 worker node. 

## ubuntu-2204
The ubuntu-2404 scenario is the simplest possible scenario, with a single Ubuntu 22.04 master node and a single Ubuntu 22.04 worker node. 


---   
# Development  
## Required ENV Vars
| Name                  | Purpose |   
| --------------------- | ------- | 
| AWS_ACCESS_KEY_ID     | Access to AWS |  
| AWS_SECRET_ACCESS_KEY | Access to AWS |  
| VPC_SUBNET_ID         | Subnet to assign EC2s to |   

## Summary  
The molecule test scenarios are based on the cookie cutter ec2 instance and require the molecule plugin here: [molecule-plugin](https://github.com/ansible-community/molecule-plugins), the pip3 `requirements.txt` can be found in this directory while the ansible specfic requirements will be installed automatically when running molecule as a part of the `requirements` stage.   
As this is an ec2 based scenario an AWS account is needed, you will need to define the following variables either as environment variables or in your aws cli config file (`~/.aws/config`)

```
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
```  

or  
```
[default]
aws_access_key_id=
aws_secret_access_key=
```
  
It is worth noting that the EC2 driver does not provide a way to login to EC2 instances, this needs to be done manually, your ssh key can be found in `~/.cache/molecule/rke2/default/id_rsa` and the default user is `ansible`, you will be able to login like so:  
`ssh ansible@000.000.000.000 -i ~/.cache/molecule/rke2/default/id_rsa` note that the keys location is dependant on the scenario name. 

The `vpc_subnet_id` key has been removed as a defined variable and is pulled from the environment variable `VPC_SUBNET_ID`. Other than the AWS keys needed this is the only environment variable required. 

# To Do
  - Add tests
    - Ensure node labels are applied
    - Ensure setting CIS profile works as expected
