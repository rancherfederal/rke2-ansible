# Table of Contents  
- [Table of Contents](#table-of-contents)
- [Air-Gap Install](#air-gap-install)
- [Collecting Your Resources](#collecting-your-resources)
  - [Relevant Variables](#relevant-variables)
    - [Tarball Install Variables](#tarball-install-variables)
      - [Example](#example)
    - [Image Variables](#image-variables)
      - [Example](#example-1)


# Air-Gap Install  
RKE2 can be installed in an air-gapped environment with two different methods. You can either deploy via the rke2-airgap-images tarball release artifact, or by using a private registry.

> [!WARNING]  
> If running on an SELinux enforcing air-gapped node, you must first install the necessary SELinux policy RPM before performing these steps. See our [RPM Documentation](https://docs.rke2.io/install/methods/#rpm) to determine what you need.

# Collecting Your Resources  
All files mentioned in the steps can be obtained from the assets of the desired released rke2 version [here](https://github.com/rancher/rke2/releases).

## Relevant Variables  

### Tarball Install Variables
The Ansible role looks for three variables to determine if/how the tarball installation method should run:  
  - `all.vars.rke2_install_tarball_url`
  - `all.vars.rke2_install_local_tarball_path`
  - `all.vars.rke2_force_tarball_install`

The `rke2_install_tarball_url` looks for a tarball at the specified URL, `rke2_install_local_tarball_path` looks for a tarball at the specified local path, and `rke2_force_tarball_install` if set to True (while the previous two are set to empty strings) will force the download of the tarballs from GitHub.  

> [!WARNING]  
> Currently there is no logic to prevent a user from defining both `rke2_install_tarball_url`, and `rke2_install_local_tarball_path`, you should only use one or the other, not both.  

Both of these variables should contain the `rke2.linux-amd64.tar.gz` tarball available from the release page referenced in [Collecting Your Resources](#collecting-your-resources).

#### Example  
In this example the full local path is given to the RKE2 tarball like so: 
__all.yaml__
```yaml
rke2_install_local_tarball_path: "{{ playbook_dir }}/docs/tarball_install_sample/files/rke2.linux-amd64.tar.gz"
```

### Image Variables
The image variables need to be given as a list, as most user will need to include more than just the RKE2 image tarball.
  - `all.vars.rke2_images_urls`
  - `all.vars.rke2_images_local_tarball_path`

#### Example  
The example below provides only a single local item to the list, but is enough to start the cluster:  
__all.yaml__
```yaml
rke2_images_local_tarball_path: 
  - "{{ playbook_dir }}/docs/tarball_install_sample/files/rke2.linux-amd64.tar.gz"
```