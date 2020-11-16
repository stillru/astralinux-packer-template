# AstraLinux Packer templates

### WARNING!
Project in ALPHA state!

## Boxes description

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


### Install your new box

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
$ vagrant up
```

# ВНИМАНИЕ!

Данный проект находится в стадии alpha!

