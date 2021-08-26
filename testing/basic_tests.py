"""
basic_tests.py - Using testinfra to run tests on ansible playbook rke2-ansible
"""

import testinfra


def test_rke2_config(host):
    assert host.file("/etc/rancher/rke2/config.yaml").contains("selinux: true")


def test_passwd_file(host):
    rke2_config = host.file("/etc/rancher/rke2/config.yaml")
    assert rke2_config.contains("selinux: true")
    assert rke2_config.user == "root"
    assert rke2_config.group == "root"
    assert rke2_config.mode == 0o640
