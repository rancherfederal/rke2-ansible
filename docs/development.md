# Table of Contents  
- [Table of Contents](#table-of-contents)
- [Dependencies](#dependencies)
- [Molecule Testing](#molecule-testing)

# Dependencies  
This playbook requires ansible.utils to run properly. Please see https://docs.ansible.com/ansible/latest/galaxy/user_guide.html#installing-a-collection-from-galaxy for more information about how to install this.

```
ansible-galaxy collection install -r requirements.yml
```

# Molecule Testing
The Molecule scenarios in `roles/rke2/molecule` use the EC2 driver to test on real instances.
You can run them locally from a laptop as long as you have AWS credentials and a VPC subnet ID.

Prerequisites:
- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` (or `AWS_PROFILE`)
- `VPC_SUBNET_ID`

Install dependencies:
```
python -m pip install -r roles/rke2/molecule/requirements.txt
ansible-galaxy collection install -r requirements.yml
```

Run a scenario:
```
cd roles/rke2
molecule test -s rocky-89
```

Available scenarios:
- `rocky-89`
- `rocky-94`
- `ubuntu-2204`
- `ubuntu-2404`
- `sles-15`
