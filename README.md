Build a Kubernetes cluster using RKE2 via Ansible
=========  
<p align="center">
  <img src="./docs/assets/RGS_Logo.png" />
</p>


> [!CAUTION]  
> The RKE2-Ansible repository has been significantly refactored. Note that configurations/inventories written for the v1.0.0 release and earlier are not compatible with v2.0.0 and on. Please see the documentation and make any adjustments necessary. 

Unofficial Rancher Government Repository
---------

Support: Please note that the code provided in this repository is not supported under any official support subscriptions. While we strive to ensure the quality and functionality of our code, we provide it on an "as-is" basis and make no guarantees regarding its performance.

Issues: We understand that issues may arise, and while we do not offer formal support, we will address reported issues on a "best effort" basis. We encourage users to report any problems or bugs they encounter, and we will do our best to address them in a timely manner.

Contributions: Contributions to this repository are welcome! If you have improvements or fixes, please feel free to submit a pull request. We appreciate your efforts to improve the quality and effectiveness of this code.

Thank you for your understanding and cooperation.

Ansible RKE2 (RKE Government) Playbook
---------

RKE2, also known as RKE Government, is Rancher's next-generation Kubernetes distribution. This Ansible playbook installs RKE2 for both the control plane and workers.

See the [docs](https://docs.rke2.io/) more information about [RKE Government](https://docs.rke2.io/).


Platforms
---------  

[![Lint](https://github.com/rancherfederal/rke2-ansible/actions/workflows/lint.yml/badge.svg)](https://github.com/rancherfederal/rke2-ansible/actions/workflows/lint.yml) [![Rocky](https://github.com/rancherfederal/rke2-ansible/actions/workflows/rocky.yml/badge.svg)](https://github.com/rancherfederal/rke2-ansible/actions/workflows/rocky.yml) [![Ubuntu](https://github.com/rancherfederal/rke2-ansible/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/rancherfederal/rke2-ansible/actions/workflows/ubuntu.yml)

The RKE2 Ansible playbook supports:
- Rocky 8, and 9
- RedHat: 8, and 9
- Ubuntu: 22, and 24


System requirements
-------------------
Deployment environment must have Ansible 2.9.0+

Usage
-----
Create an Ansible inventory file (or folder), you can check the docs folder for examples (`basic_sample_inventory` or `advanced_sample_inventory`).

> [!NOTE]  
> More detailed information can be found [here](./docs/README.md)

Start provisioning the cluster using the following command:
```bash
ansible-playbook site.yml -i inventory/hosts.yml -b
```  


Tarball Install/Air-Gap Install  
-------------------------------  
Air-Gap/Tarball install information can be found [here](./docs/tarball_install.md)


Kubeconfig
----------
The root user will have the `kubeconfig` and `kubectl` made available, to access your cluster login into any server node and `kubectl` will be available for use immediately. 


Uninstall RKE2  
---------------  
    Note: Uninstalling RKE2 deletes the cluster data and all of the scripts.
The official documentation for fully uninstalling the RKE2 cluster can be found in the [RKE2 Documentation](https://docs.rke2.io/install/uninstall/).

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
