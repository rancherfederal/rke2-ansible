"""
basic_tests.py - Using testinfra to run tests on ansible playbook rke2-ansible
"""

import testinfra


def test_rke2_config(host):
    rke2_config = host.file("/etc/rancher/rke2/config.yaml")
    assert rke2_config.user == "root"
    assert rke2_config.group == "root"
    assert rke2_config.mode == 0o640


def test_rke2_server_running_and_enabled(host):
    rke2_server = host.service("rke2-server")
    assert rke2_server.is_running
    assert rke2_server.is_enabled
