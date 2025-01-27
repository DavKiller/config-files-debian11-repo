# Debian 11 Repository

## Introducction

This is a collection of configuration files to make a personal Debian 11 repository, it can be used to manage the packages that can be installed and to save bandwidth.
This way of creating a Debian repository allows you great flexibility, but forces you to download all the packages you need since you are not cloning the main Debian repository, you are creating one from scratch.

This project is being done by using the following skills:

![image](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white) ![image](https://img.shields.io/badge/Linux-E34F26?style=for-the-badge&logo=linux&logoColor=black) ![image](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)
![image](https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white) ![image](https://img.shields.io/badge/Git-E34F26?style=for-the-badge&logo=git&logoColor=white)

## Installations

We make a update to be sure to use the last version of the packages to start installing things.

```bash
apt update
```

We install the Web server.  
When the client add a line to `sources.list` need a protocol to transfer the packages, you can use a HTTP/S , FTP server or RSH/SSH, you can see more about this in the man of the `sources.list` here: https://manpages.debian.org/bullseye/apt/sources.list.5.en.html

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

Now we make a folder to save the `*.deb` where you want.

```bash
mkdir /home/user/packages
```

## Making the repository

First of all we will create the necessary folder structure for the repository configuration

```bash
mkdir -p /var/packages/debian/conf
```

Now we need to make in the folder `/var/packages/debian/conf` a file called `distributions`
This file contain the config of the repository, you can see [here](https://github.com/DavKiller/config-files-debian11-repo/blob/main/packages/debian/conf/distributions) a example of the file.

⚠️ In `SignWith: 1B746D0E239D2876` line 7 of the example file you need to put your Public Key.

Now we do in the same folder a file called `options` you can see [here](https://github.com/DavKiller/config-files-debian11-repo/blob/main/packages/debian/conf/options) a example of the file, check the basedir.

To finish in `/var/packages/debian/conf` you need to make a empty file called `override.testing` The name will depend on the configuration parameter of the `distributions` file

Now we need to put a EXPORTED PUBLIC KEY in the base folder of the web server, because we need it to get it as a client.

```bash
gpg --armor --output /var/packages/debian/192.168.134.132.gpg.key --export 1B746D0E239D2876
```

## Add packages to the repository

To add packages to the repository we need to be folder of what we have done before.

```bash
cd /var/packages/debian/
```

From this folder we will use the following command to add the packages that we have stored.

```bash
reprepro includedeb testing /var/www/repo/*.deb
```

This command adds to the repository whose codename is `testing` all the .deb files in the specified folder.
When using the command, it will ask us for the password of the certificate that we have created and used for the repository.

## Script to download the packages and add it to the local repository [![Codacy Security Scan](https://github.com/DavKiller/config-files-debian11-repo/actions/workflows/codacy.yml/badge.svg)](https://github.com/DavKiller/config-files-debian11-repo/actions/workflows/codacy.yml)

You can use this script to download the packages from the Debian repository.

```bash
downloader.sh <package1> <package2> <package3>
```

This script has a local variables that you need to change if is necesary:
All of this values you can see are the default values.

```bash
R_PACK="/var/www/repo"
R_REPO="/var/packages/debian"
CODENAME="testing"
```

R_PACK is the folder where the script will search for the packages.
R_REPO is the folder where the reprepro repository its located.
CODENAME is the codename of the repository you made.

If you only want download packages and not add them to the repository, you can comment the last part of the script, to line 45 to line 50.

## Using the repository as a client.

First of all we need to add a line in the `sources.list` like this:

```bash
deb http://192.168.134.132 testing main
```

Then we need to add the public key to the machine, so we download it and then we add it

```bash
wget http://192.168.134.132/192.168.134.132.gpg.key
```

```bash
apt-key add 192.168.134.132.gpg.key
```

And the final step, lets do a update and now we can use the repository we have created.

```bash
apt update
```

---

made with ❤️ by [DavKiller](https://github.com/DavKiller).

Integrated Proyect for ASIR.
