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

Unofficial Rancher Government Repository
---------

Support: Please note that the code provided in this repository is not supported under any official support subscriptions. While we strive to ensure the quality and functionality of our code, we provide it on an "as-is" basis and make no guarantees regarding its performance.

Issues: We understand that issues may arise, and while we do not offer formal support, we will address reported issues on a "best effort" basis. We encourage users to report any problems or bugs they encounter, and we will do our best to address them in a timely manner.

Contributions: Contributions to this repository are welcome! If you have improvements or fixes, please feel free to submit a pull request. We appreciate your efforts to improve the quality and effectiveness of this code.

Thank you for your understanding and cooperation.

Ansible RKE2 (RKE Government) Playbook
---------
[![LINT](https://github.com/rancherfederal/rke2-ansible/actions/workflows/ci.yml/badge.svg)](https://github.com/rancherfederal/rke2-ansible/actions/workflows/ci.yml)

RKE2, also known as RKE Government, is Rancher's next-generation Kubernetes distribution. This Ansible  playbook installs RKE2 for both the control plane and workers.

See the [docs](https://docs.rke2.io/) more information about [RKE Government](https://docs.rke2.io/).


Platforms
---------
The RKE2 Ansible playbook supports all [RKE2 Supported Operating Systems](https://docs.rke2.io/install/requirements/#operating-systems)

Supported Operating Systems:
- SLES 15
- Rocky 8 and 9
- RedHat: 8 and 9
- Ubuntu: 18, 20, and 22


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

Second, edit `inventory/my-cluster/hosts.yaml` to match the system information gathered above. For example:

```yaml
rke2_cluster:
  children:
    rke2_servers:
      hosts:
        server1.example.com:
    rke2_agents:
      hosts:
        agent1.example.com:
        agent2.example.com:
          node_labels:
          - agent2Label=true"
all:
  vars:
    install_rke2_version: v1.27.10+rke2r1
```

If needed, you can also edit `inventory/my-cluster/group_vars/rke2_agents.yml` and `inventory/my-cluster/group_vars/rke2_servers.yml` to match your environment.

Start provisioning of the cluster using the following command:

```bash
ansible-playbook site.yml -i inventory/my-cluster/hosts.yml
```

Tarball Install/Air-Gap Install
-------------------------------
Added the neeed files to the [tarball_install](tarball_install/) directory.

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

If you used this module to created the cluster and RKE2 was installed via yum, then you can attempt to run this command to remove all cluster data and all RKE2 scripts.

Replace `ec2-user` with your ansible user.
```bash
ansible -i 18.217.113.10, all -u ec2-user -a "/usr/bin/rke2-uninstall.sh"
```

If the tarball method was used then you can attempt to use the following command:
```bash
ansible -i 18.217.113.10, all -u ec2-user -a "/usr/local/bin/rke2-uninstall.sh"
```
On rare occasions you may have to run the uninstall commands a second time.

Known Issues
------------------
- For RHEL8+ Operating Systems that have fapolicyd daemon running, rpm installation of RKE2 will fail due to a permission error while starting containerd. Users have to add the following rules file before installing RKE2. This is not an issue if the install.sh script is used to install RKE2. The RPM issue is expected to be fixed in later versions of RKE2.
```bash
cat <<-EOF >>"/etc/fapolicyd/rules.d/80-rke2.rules"
allow perm=any all : dir=/var/lib/rancher/
allow perm=any all : dir=/opt/cni/
allow perm=any all : dir=/run/k3s/
allow perm=any all : dir=/var/lib/kubelet/
EOF

systemctl restart fapolicyd

```


Author Information
------------------

[Rancher Government Solutions](https://ranchergovernment.com/)
