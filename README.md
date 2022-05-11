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
## Making the repository

First of all we will create the necessary folder structure for the repository configuration
```bash
mkdir -p /var/packages/debian/conf
```
Now we need to make in the folder ```/var/packages/debian/conf``` a file called ```distributions```
This file contain the config of the repository, you can see [here](https://github.com/DavKiller/config-files-debian11-repo/blob/main/packages/debian/conf/distributions) a example of the file.
 
 ⚠️ In ```SignWith: 1B746D0E239D2876``` line 7 of the example file you need to put your Public Key. 

Now we do in the same folder a file called ```options``` you can see [here](https://github.com/DavKiller/config-files-debian11-repo/blob/main/packages/debian/conf/options) a example of the file, check the basedir.

To finish in ```/var/packages/debian/conf``` you need to make a empty file called ```override.testing```  The name will depend on the configuration parameter of the ```distributions``` file

Now we need to put a EXPORTED PUBLIC KEY in the base folder of the web server, because we need it to get it as a client.
gpg --armor --output /var/packages/debian/192.168.134.132.gpg.key --export 1B746D0E239D2876

## Writing
---
made with ❤️ by [DavKiller](https://github.com/DavKiller). 

Integrated Proyect for ASIR.
