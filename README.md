[//]: #@corifeus-header

  [![Build Status](https://travis-ci.org/patrikx3/docker-debian-testing-mongodb-stable.svg?branch=master)](https://travis-ci.org/patrikx3/docker-debian-testing-mongodb-stable)  [![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/patrikx3/docker-debian-testing-mongodb-stable/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/patrikx3/docker-debian-testing-mongodb-stable/?branch=master)  [![Code Coverage](https://scrutinizer-ci.com/g/patrikx3/docker-debian-testing-mongodb-stable/badges/coverage.png?b=master)](https://scrutinizer-ci.com/g/patrikx3/docker-debian-testing-mongodb-stable/?branch=master) 

# Debian Stretch / Buster / Bullseye / Testing MongoDB and MongoDB Tools build stable 

 
                        
[//]: #@corifeus-header:end

It is basically a built for the latest MongoDB for Debian.

The current varsion is the r3.6.x build (release).

### Warning

It will remove all ```mongodb*``` apt packages in ```./scripts/build-server.sh``` and ```/etc/systemd/system/mongodb-server.service``` is replaced.  

It install the required apt dependencies and generates the ```SystemD``` service and makes it enabled.  

For testing, you may build it in Docker, but the live building is on the server in the directory in the GIT repository ```build``` directory and then it puts the files into ```/usr/bin```.  

Before you start the database, but after the build, you are required to create a config, a skeleton is here:  
```artifacts/root-filesystem/etc/mongodb.conf```.

Like:


#### Add safety to the mongodb config file

```bash
cp ./artifacts/root-filesystem/etc/mongodb.conf /etc/mongodb.conf
chmod o-rwx /etc/mongodb.conf
chown mongodb:mongodb /etc/mongodb.conf
```

After you created the config, you start the database like:  
```service mongodb-server start```


## Scripts

It can work with sudo, but the best if you are ```root```. Of course, you can check the ```code```, there is no ```harm``` for sure!

```bash
git https://github.com/patrikx3/docker-debian-testing-mongodb-stable
cd docker-debian-testing-mongodb-stable
```

If below you get an error, please create and ```issue```, because it is possible I did not added a package, because my server was already there, but I will add in it for you for sure with ```apt```.  

### 1. Build MongoDB Server

The command:
```bash
sudo ./scripts/build-server.sh
```

From:  
https://github.com/mongodb/mongo/wiki/Build-Mongodb-From-Source

All defaults are in the config are the MongoDB uses:  
* /var/log/mongodb - log
* /var/lib/mongodb - data

It generates everything, all you have to do:

```bash
sudo ./scripts/build-server.sh r3.6.3
```

### 2. Build MongoDB Tools

The command:
```bash
./scripts/build-tools.sh
```

It generates and install GoLang and builds the tools that you find them in:    
https://github.com/mongodb/mongo-tools

Then it puts all tools into the default Debian ```/usr/bin``` directories.

The exact command is like:
```bash
sudo ./scripts/build-tools.sh r3.6.3
```

<!---

### 3. Sometimes check the kernel


The command:
```bash
./scripts/check-kernel.sh
```

It the kernel have changed, it better to re-build the server and the tools.

Right now the stable MongoDB 3.6.3 doesn't show the kernel version anymore

<!---
# Add user

```bash
cp ./artifacts/root-filesystem/etc/systemd/system/mongodb-server.service /etc/systemd/system/mongodb.service
cp ./artifacts/root-filesystem/etc/mongodb.conf /etc/mongodb.conf
sudo useradd mongodb -d /var/lib/mongodb -s /bin/false || true
sudo -u mongodb mkdir -p /var/lib/mongodb
sudo chmod o-rwx -R /var/lib/mongodb
systemctl daemon-reload
systemctl enable mongodb-server
service mongodb-server start
```

--->

[//]: #@corifeus-footer

---

[**P3X-DOCKER-DEBIAN-TESTING-MONGODB-STABLE**](https://pages.corifeus.com/docker-debian-testing-mongodb-stable) Build v3.6.160-125 

[![Like Corifeus @ Facebook](https://img.shields.io/badge/LIKE-Corifeus-3b5998.svg)](https://www.facebook.com/corifeus.software) [![Donate for Corifeus / P3X](https://img.shields.io/badge/Donate-Corifeus-003087.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QZVM4V6HVZJW6)  [![Contact Corifeus / P3X](https://img.shields.io/badge/Contact-P3X-ff9900.svg)](https://www.patrikx3.com/en/front/contact) 


## Sponsor

[![JetBrains](https://www.patrikx3.com/images/jetbrains-logo.svg)](https://www.jetbrains.com/)
  
 

[//]: #@corifeus-footer:end