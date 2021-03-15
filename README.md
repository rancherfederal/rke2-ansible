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
The RKE2 Ansible role only supports CentOS and Red Hat, but will eventually support all [RKE2 Supported Operating Systems](https://docs.rke2.io/install/requirements/#operating-systems)

Currently supported:
```yaml
CentOS:
  - 7.8
  - 8.2
Red Hat:
  - 7.8
  - 8.2
```
TODO: Add Support for
```yaml
Ubuntu:
  - bionic
  - focal
```


System requirements
-------------------

Deployment environment must have Ansible 2.9.0+

Server and agent nodes must have passwordless SSH access

Usage
-----

First create a new directory based on the `sample` directory within the `inventory` directory:

```bash
cp -R inventory/sample inventory/my-cluster
```

Second, edit `inventory/my-cluster/hosts.ini` to match the system information gathered above. For example:

```bash
[server]
192.16.35.12

[agent]
192.16.35.[10:11]

[rke2_cluster:children]
server
agent
```

If needed, you can also edit `inventory/my-cluster/group_vars/all.yml` to match your environment.

Start provisioning of the cluster using the following command:

```bash
ansible-playbook site.yml -i inventory/my-cluster/hosts.ini
```

Kubeconfig
----------

To get access to your **Kubernetes** cluster just

```bash
ssh ec2-user@server_ip "sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml get nodes"
```

Available configurations
------------------------
Server Configurations

| Options | Descriptions|
|---------|-------------|
| cis_15_enabled | Validate system configuration against the CIS 1.5 benchmark (default: false) |
| rke2_channel | Channel to use for fetching the desired RKE2 version.  (default: stable, available: latest, stable, v1.19, v1.18)
| rke2_config_token | Shared secret used to join a server or agent to a cluster. (default: Automatically created) |
| rke2_write_kubeconfig_mode | Write kubeconfig with this mode (default: "0644" ) |
| tls_san | Add additional hostname or IP as a Subject Alternative Name in the TLS cert ie. ["compute.internal", "branch.mil"] |

These variables can be modified in the specific roles (`{role}/vars/main.yml`) or can be set in your `inventory/cluster/group_vars/all.yml`


Author Information
------------------

[Dave Vigil](https://github.com/dgvigil)

[Brandon Gulla](https://github.com/bgulla)

[Rancher Federal](https://rancherfederal.com/)
