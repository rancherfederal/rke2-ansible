Build a Kubernetes cluster using RKE2 via Ansible
=========
```
               ,        ,  _______________________________
   ,-----------|'------'|  |                             |
  /.           '-'    |-'  |_____________________________|
 |/|             |    |
   |   .________.'----'    _______________________________
   |  ||        |  ||      |                             |
   \__|'        \__|'      |_____________________________|

|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|
|________________________________________________________|

|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|
|________________________________________________________|
```

Ansible RKE2 (RKE Government) Playbook
---------
[![LINT](https://github.com/rancherfederal/rke2-ansible/actions/workflows/ci.yml/badge.svg)](https://github.com/rancherfederal/rke2-ansible/actions/workflows/ci.yml)

RKE2, also known as RKE Government, is Rancher's next-generation Kubernetes distribution. This Ansible  playbook installs RKE2 for both the control plane and workers.

See the [docs](https://docs.rke2.io/) more information about [RKE Government](https://docs.rke2.io/).


Platforms
---------
The RKE2 Ansible playbook supports all [RKE2 Supported Operating Systems](https://docs.rke2.io/install/requirements/#operating-systems)

Supported Operating Systems:
```yaml
SLES:
  - 15 SP2 (amd64)
CentOS:
  - 7.8 (amd64)
  - 8.2 (amd64)
Red Hat:
  - 7.8 (amd64)
  - 8.2 (amd64)
Ubuntu:
  - bionic/18.04 (amd64)
  - focal/20.04 (amd64)
```


System requirements
-------------------

Deployment environment must have Ansible 2.9.0+

Server and agent nodes must have passwordless SSH access

Usage
-----

This playbook requires ansible.utils to run properly. Please see https://docs.ansible.com/ansible/latest/galaxy/user_guide.html#installing-a-collection-from-galaxy for more information about how to install this.

```
ansible-galaxy collection install -r requirements.yml
```

Create a new directory based on the `sample` directory within the `inventory` directory:

```bash
cp -R inventory/sample inventory/my-cluster
```

Second, edit `inventory/my-cluster/hosts.ini` to match the system information gathered above. For example:

```bash
[rke2_servers]
192.16.35.12

[rke2_agents]
192.16.35.[10:11]

[rke2_cluster:children]
rke2_servers
rke2_agents
```

If needed, you can also edit `inventory/my-cluster/group_vars/rke2_agents.yml` and `inventory/my-cluster/group_vars/rke2_servers.yml` to match your environment.

Start provisioning of the cluster using the following command:

```bash
ansible-playbook site.yml -i inventory/my-cluster/hosts.ini
```

Tarball Install/Air-Gap Install
-------------------------------
Added the neeed files to the [tarball_install](tarball_install]/) directory.

Further info can be found [here](tarball_install/README.md)


Kubeconfig
----------

To get access to your **Kubernetes** cluster just

```bash
ssh ec2-user@kubernetes_api_server_host "sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml get nodes"
```

Available configurations
------------------------

Variables should be set in `inventory/cluster/group_vars/rke2_agents.yml` and `inventory/cluster/group_vars/rke2_servers.yml`. See sample variables in `inventory/sample/group_vars` for reference.


Uninstall RKE2
---------------
    Note: Uninstalling RKE2 deletes the cluster data and all of the scripts.
The offical documentation for fully uninstalling the RKE2 cluster can be found in the [RKE2 Documentation](https://docs.rke2.io/install/uninstall/).

Nodes can be removed from a cluster and RKE2 uninstalled by adding the node to the [rke2_uninstall] section of the hosts file.

```bash
[rke2_servers]
192.16.35.12

[rke2_agents]
192.16.35.10

[rke2_uninstall]
192.16.35.11

[rke2_cluster:children]
rke2_servers
rke2_agents
```

Author Information
------------------

[Dave Vigil](https://github.com/dgvigil)

[Brandon Gulla](https://github.com/bgulla)

[Rancher Federal](https://rancherfederal.com/)

[Mike D'Amato](https://github.com/mdamato)
