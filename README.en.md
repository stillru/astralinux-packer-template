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

# Description

## Project Goal

This project goal - create `pcaker` teamplate usefull for creation `vagrant box` with debian derivative `Astra Linux Common Edition`.

## Prerequisites

- (required) `packer` == 1.6.5
- (required) `vagrant` => 2.2.13
- (required) `ansible` => 2.10.2


## Getting started

### Configure variables in astra-common-x.x.x-netinst.json

For correct working pipeline you should correct this variables in file:


 | Level        | Variable     | Description                                                                          |
 |--------------|--------------|--------------------------------------------------------------------------------------|
 | [required]   | `ip_address` | ip-address of host machine.                                                          |
 | [optional]   | `cpus`       | CPU cores for construction.                                                          |
 | [optional]   | `name`       | hostname of VM.                                                                      |
 | [optional]   | `domain`     | domain of VM.                                                                        |
 | [required]   | `version`    | Operatin System Version - used for generation some files and file-structure creation |
 | [do not edit]| `user`       | Default username unprivilaged user.                                                  |
 | [do not edit]| `password`   | Default password unprivilaged user.                                                  |
 | [optional]   | `size`       | HDD virchual size. Default variable "30000" bytes.                                   |
 | [optional]   | `mirror`     | URI for iso-image.                                                                   |
 | [required]   | `md5sum`     | MD5 for iso-image.                                                                   |

### Configure variables in ansible/vars.yml

!! Doc in progress

## Generate new box

### Generate box with GUI

Command to run `packer`:

``` shell
packer build -var version=x.x.x -var type=Desktop astra-common-x.x.x-netinst.json
```

Variable `version` not required.

Variable `type` is required and shuld be `Desktop` or `Server`. Depend of witch type you need.

All variables like `x.x.x` shuld be replaced with actual var. Need attention to file `astra-orel-x.x.x-Desktop.cfg` or `astra-orel-x.x.x-Server.cfg` at `http` directory.

At the end of process you shuld see something like:

``` shell
Build 'astra-orel' finished after 1 hour 50 minutes.

==> Wait completed after 1 hour 50 minutes

==> Builds finished. The artifacts of successful builds are:
--> astra-orel: 'libvirt' provider box: boxes/astra-orel/libvirt/x.x.x/astra-orel-x.x.x-Desktop.box
```
### Generate box without GUI

!! Work in progress

## Install your new box


```
$ vagrant box add astra-orel-x.x.x boxes/astra-orel/libvirt/x.x.x/astra-orel-x.x.x-Desktop.box --force
```

The VM image has been imported to vagrant, it's now available on your system.


## Vagrant

### Getting Started

To use this image with Vagrant, create a vagrant file:

```
$ vagrant init astra-orel-x.x.x-Desktop
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
