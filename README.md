# GitLab POC/POV Infrastructure Repo

This repo contains Ansible and Terraform config to create a simple GitLab server for Proof of Concept work and generating
POVs.

## Running This

### Prerequisites
* `ansible-galaxy` cli tool
* Ansible roles: 
  * `geerlingguy.gitlab` 
  * `geerlingguy.nginx`
* Ansible will fail on authenticity check so you can `export ANSIBLE_HOST_KEY_CHECKING=false` for now

## Local Development with Vagrant and Ansible
If you want to do local development work then you must first adjust the gitlab.yml hosts. You must change
`- hosts: gitlab` to `- hosts: all`. This will allow Vagrant to generate an inventory for you.