
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
# Air-Gap Install

RKE2 can be installed in an air-gapped environment with two different methods. You can either deploy via the rke2-airgap-images tarball release artifact, or by using a private registry.

All files mentioned in the steps can be obtained from the assets of the desired released rke2 version [here](https://github.com/rancher/rke2/releases).

If running on an SELinux enforcing air-gapped node, you must first install the necessary SELinux policy RPM before performing these steps. See our [RPM Documentation](https://github.com/rancher/rke2#rpm-repositories) to determine what you need.

# Tarball Method
This ansible playbook will detect if the `rke2-images.linux-amd64.tar.zst` and `rke2.linux-amd64.tar.gz` files are in the tarball_install/ directory. If the files are in the directory then the install process will skip both the yum install and the need to download the tarball.

## Images Install
If either the `rke2-images.linux-amd64.tar.zst` or `rke2-images.linux-amd64.tar.gz` files are found in the tarbarll_install/ directory then this playbook will use the images inside the tarball and not docker.io or a private registry.

## Tarball Install
If the `rke2.linux-amd64.tar.gz` file is found in the tarball_install/ directory then this playbook will install RKE2 using that version. This will use the default docker.io registry unless the images tarball is present or unless the `system-default-registry` variable is set.