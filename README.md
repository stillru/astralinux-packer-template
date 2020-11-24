# AstraLinux Packer templates

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [AstraLinux Packer templates](#astralinux-packer-templates)
    - [ВНИМАНИЕ!](#внимание)
- [ПРОЧТИМЕНЯ :-)](#прочтименя--)
    - [Описание](#описание)
    - [Необходимые условия для запуска](#необходимые-условия-для-запуска)
    - [Первые шаги](#первые-шаги)
        - [Настроить переменные в файле astra-common-x.x.x-netinst.json](#настроить-переменные-в-файле-astra-common-xxx-netinstjson)
        - [Настроить vars.yml](#настроить-varsyml)
    - [Запуск сборки машины](#запуск-сборки-машины)
        - [Сборка виртуальной машины c GUI](#сборка-виртуальной-машины-c-gui)
        - [Сборка виртуальной машины без GUI](#сборка-виртуальной-машины-без-gui)
        - [WARNING!](#warning)
    - [Boxes description](#boxes-description)
    - [Prerequisites](#prerequisites)
    - [Build vagrant box](#build-vagrant-box)
        - [Install your new box](#install-your-new-box)
    - [Vagrant](#vagrant)
        - [Getting Started](#getting-started)

<!-- markdown-toc end -->


## ВНИМАНИЕ!
[1:]
Данный проект находится в стадии alpha!

# ПРОЧТИМЕНЯ :-)

## Описание
Проект для автоматического создания витуальных машин `vagrant` на основе `Astra Linux Common Edition` с помошью инструмента `packer`.

## Необходимые условия для запуска

- (обязательно) `packer` == 1.6.5
- (обязательно) `vagrant` => 2.2.13
- (обязательно) `ansible` => 2.10.2

## Первые шаги

### Настроить переменные в файле astra-common-x.x.x-netinst.json
Для корректной сборки проекта необходимо заменить некоторые переменные в секции `variables` данного файла:

 | Замена        | Имя поля     | Описание                                                                                      |
 |---------------|--------------|-----------------------------------------------------------------------------------------------|
 | [обязательно] | `ip_address` | ip-адрес машины на которой происходит сборка виртуальной машины.                              |
 | [опционально] | `cpus`       | Количество ядер для сборки.                                                                   |
 | [опционально] | `name`       | hostname виртуальной машины.                                                                  |
 | [опционально] | `domain`     | domain виртуальной машины.                                                                    |
 | [обязательно] | `version`    | Версия ОС - используется в нескольких местах для создания структур папок и именования файлов. |
 | [не менять  ] | `user`       | Пользователь от имени которого будет производиться преднастройка машины.                      |
 | [не менять  ] | `password`   | Пароль пользователя для настройки машины                                                      |
 | [опционально] | `size`       | Размер HDD. Выставлено значение "30000".                                                      |
 | [опционально] | `mirror`     | Сайт с которого будет скачиваться iso-образ.                                                  |
 | [обязательно] | `md5sum`     | Контрольная сумма md5 для iso-образа                                                          |

Настоятельно рекомендуется не менять значение `user` и `password` - используются принятые в сообществе значения для данных переменных. В противном случае будет необходимо дополнительно настраивать `ansible` для работы с новыми значениями данных полей.

### Настроить vars.yml
Данный файл находится в каталоге `ansible/vars`

Все переменные (целых три) дублируют переменнные `packer`.

## Запуск сборки машины

### Сборка виртуальной машины c GUI

Запуск сборки выполняется командой:

``` shell
packer build -var version=x.x.x -var type=Desktop astra-common-x.x.x-netinst.json
```

Параметр `version` не является обязательным.

Параметр `type` является обязательным и должен принимать значение `Desktop`.

Все значения `x.x.x` необходимо заменить реальными значениями. А так же проверить что в папке `http` существует файл вида `astra-orel-x.x.x-Desktop.cfg`

По окончании сборки в терминале должно появиться сообщение следующего вида

``` shell
Build 'astra-orel' finished after 1 hour 50 minutes.

==> Wait completed after 1 hour 50 minutes

==> Builds finished. The artifacts of successful builds are:
--> astra-orel: 'libvirt' provider box: boxes/astra-orel/libvirt/x.x.x/astra-orel-x.x.x.box
```

### Сборка виртуальной машины без GUI

!! Раздел в разработке

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
