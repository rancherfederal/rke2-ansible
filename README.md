Ansible RKE2 (RKE Government) Role
=========
[![LINT](https://github.com/rancherfederal/rke2-ansible/actions/workflows/ci.yml/badge.svg)](https://github.com/rancherfederal/rke2-ansible/actions/workflows/ci.yml)

RKE2, also known as RKE Government, is Rancher's next-generation Kubernetes distribution. This Ansible role installs RKE2 for both the control plane and workers.

See the [docs](https://docs.rke2.io/) more information about [RKE Government](https://docs.rke2.io/).

Requirements
------------
### Ansible

*   This role is developed and tested with [maintained](https://docs.ansible.com/ansible/devel/reference_appendices/release_and_maintenance.html) versions of Ansible base.

### Molecule

*   Molecule `3.x` is used to test the various functionalities of the role.
*   Instructions on how to install Molecule can be found in the [Molecule website](https://molecule.readthedocs.io/en/latest/installation.html).


Installation
------------
### Ansible Galaxy

Use `ansible-galaxy install rancherfederal.rke2-ansible` to install the latest stable release of the role on your system.

### Git

Use `git clone https://github.com/rancherfederal/rke2-ansible.git` to pull the latest edge commit of the role from GitHub.

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


Role Variables
--------------

This role has multiple variables. The descriptions and defaults for all these variables can be found in the **[`defaults/main/`](https://github.com/rancherfederal/rke2-ansible/blob/main/defaults/main/)** folder in the following files:

|Name|Description|
|----|-----------|
|**[`main.yml`](https://github.com/rancherfederal/rke2-ansible/blob/main/defaults/main/main.yml)**|RKE2 installation variables|


Similarly, descriptions and defaults for preset variables can be found in the **[`vars/`](https://github.com/rancherfederal/rke2-ansible/blob/main/vars/)** folder in the following files:

|Name|Description|
|----|-----------|
|**[`main.yml`](https://github.com/rancherfederal/rke2-ansible/blob/main/vars/main.yml)**|List of supported  currently variables|


Example Playbook
----------------

Add the following to the full playbook:

    - hosts: all
      become: yes
      roles:
         - rke2-ansible


Inventory should be broken up between control plan nodes and worker nodes.

    [control_plane]
    192.168.0.3
    192.168.0.4
    192.168.0.5

    [workers]
    192.168.0.10
    192.168.0.11
    192.168.0.12
    192.168.0.13



License
-------

MIT

Author Information
------------------

[Dave Vigil](https://github.com/dgvigil)

[Brandon Gulla](https://github.com/bgulla)

[Rancher Federal](https://rancherfederal.com/)
