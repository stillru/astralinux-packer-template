<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [WARNING!](#warning)
- [Boxes description](#boxes-description)
    - [Prerequisites](#prerequisites)
    - [Build vagrant box](#build-vagrant-box)
    - [Install your new box](#install-your-new-box)
    - [Vagrant](#vagrant)
        - [Getting Started](#getting-started)
        - [FB Post](#fb-post)

<!-- markdown-toc end -->

# WARNING!
Project in ALPHA state!

# Boxes description

* OS : AstraLinux 1.12.22 amd64
* 1024MB Ram, 2 CPU
* Vagrant ssh key are installed on vagrant and root users


## Prerequisites

```
$ brew cask install packer vagrant virtualbox ansible
```

## Build vagrant box

```
$ packer build -var 'type=Desktop' astra-orel-1.12.29-netinst.json
```


## Install your new box

```
$ vagrant box add astra-orel-1.12.29 ./boxes/astra-orel-1.12.29.box --force
```

The VM image has been imported to vagrant, it's now available on your system.


## Vagrant

### Getting Started

To use this image with Vagrant, create a vagrant file:

```
$ vagrant init astra-orel-1.12.29
```


Add this line in `Vagrantfile`:

```
config.vm.synced_folder '.', '/home/vagrant/sync', disabled: true
```


And initialize the vm:

```
$ vagrant up --provider libvirt
```


### FB Post
Hello from cold Russian Capital!

Let me introduce you my first packer template and another debian based distro.

I need some help with testing this template. On my machine all work pretty well. But i havent another one to test in different circumstances. https://github.com/stillru/astralinux-packer-template
