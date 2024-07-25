# Molecule Scenarios  
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

# Available Scenarios  
## default  
The default scenario is the simplest possible scenario, with a single Ubuntu 20.04 master node and a single Ubuntu 20.04 worker node. 

# To Do
  - Add tests
    - Ensure node labels are applied
    - Ensure setting CIS profile works as expected
  - Add scenrios for all supported platforms
    - Rocky
    - SLES