# Debian 11 Repository
## Introducction
This is a collection of configuration files to make a personal Debian 11 repository, it can be used to manage the packages that can be installed and to save bandwidth.
This way of creating a Debian repository allows you great flexibility, but forces you to download all the packages you need since you are not cloning the main Debian repository, you are creating one from scratch.

## Installations
We make a update to be sure to use the last version of the packages to start installing things.
```bash
apt update
```
We install the Web server.  
When the client add a line to ```sources.list``` need a protocol to transfer the packages, you can use a HTTP/S , FTP server or RSH/SSH, you can see more about this in the man of the ```sources.list``` here: https://manpages.debian.org/bullseye/apt/sources.list.5.en.html
```bash
apt install nginx
```
We install gnupg to create the certificate
```bash
apt install gnupg
```
We install reprepro to make the repository.
```bash
apt install reprepro
```

## Configuration of the repository

First of all we need to make a certificate to use reprepro.
```bash
gpg --gen-key
```
Then we need the public key, we will put it in a file to get easily.
This will export all keys we generated, be sure you know what public key to use.
```bash
 gpg --list-secret-keys --keyid-format LONG > keys.txt
```
Now we make a folder to save the ```*.deb``` where you want.
```bash
mkdir /home/user/packages
```
## Under costruction


---
made with ❤️ by [DavKiller](https://github.com/DavKiller). 

Integrated Proyect for ASIR.
