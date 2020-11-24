# AstraLinux Packer templates
<!--ts-->
   * [AstraLinux Packer templates](#astralinux-packer-templates)
         * [WARNING!](#warning)
      * [Boxes description](#boxes-description)
      * [Prerequisites](#prerequisites)
      * [Build vagrant box](#build-vagrant-box)
         * [Install your new box](#install-your-new-box)
      * [Vagrant](#vagrant)
         * [Getting Started](#getting-started)
   * [ВНИМАНИЕ!](#\xD0\xB2\xD0\xBD\xD0\xB8\xD0\xBC\xD0\xB0\xD0\xBD\xD0\xB8\xD0\xB5)

<!-- Added by: still, at: Ср ноя 25 01:42:53 MSK 2020 -->

<!--te-->
## ВНИМАНИЕ!
Данный проект находится в стадии alpha!

#ПРОЧТИМЕНЯ :-)

##Описание
Проект для автоматического создания витуальных машин `vagrant` на основе `Astra Linux Common Edition` с помошью инструмента `packer`.

##Необходимые условия для запуска

- (обязательно) `packer` == 1.6.5
- (обязательно) `vagrant` => 2.2.13

##Первые шаги

###Настроить переменные в файле astra-common-x.x.x-netinst.json
Для корректной сборки проекта необходимо заменить некоторые переменные в секции `variables` данного файла:

 - [обязательно] - "ip_address" - ip-адрес машины на которой происходит сборка виртуальной машины.
 - [опционально] - "cpus"       - Количество ядер для сборки.
 - [опционально] - "name"       - hostname виртуальной машины.
 - [опционально] - "domain"     - domain виртуальной машины.
 - [обязательно] - "version"    - Версия ОС - используется в нескольких местах для создания структур папок и именования файлов.
 - [не менять  ] - "user"       - Пользователь от имени которого будет производиться преднастройка машины.
 - [не менять  ] - "password"   - Пароль пользователя для настройки машины
 - [опционально] - "size"       - Размер HDD. Выставлено значение "30000".
 - [опционально] - "mirror"     - Сайт с которого будет скачиваться iso-образ.
 - [обязательно] - "md5sum"     - Контрольная сумма md5 для iso-образа

Настоятельно рекомендуется не менять значение `user` и `password` - используются принятые в сообществе значения для данных переменных. В противном случае будет необходимо дополнительно настраивать `ansible` для работы с новыми значениями данных полей.


###
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
$ vagrant up --provider libvirt
```


