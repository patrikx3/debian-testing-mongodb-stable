[//]: #@corifeus-header

  [![Build Status](https://travis-ci.org/patrikx3/docker-debian-testing-mongodb-stable.svg?branch=master)](https://travis-ci.org/patrikx3/docker-debian-testing-mongodb-stable)  [![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/patrikx3/docker-debian-testing-mongodb-stable/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/patrikx3/docker-debian-testing-mongodb-stable/?branch=master)  [![Code Coverage](https://scrutinizer-ci.com/g/patrikx3/docker-debian-testing-mongodb-stable/badges/coverage.png?b=master)](https://scrutinizer-ci.com/g/patrikx3/docker-debian-testing-mongodb-stable/?branch=master) 

# Debian Stretch / Buster / Bull / Bullseye MongoDB and MongoDB Tools build stable 

 
                        
[//]: #@corifeus-header:end

It is basically a built for the latest MongoDB for Debian.

The current varsion is the r3.6.x build (release).

### Warning

It will remove all ```mongodb*``` apt packages in ```./scripts/build-server.sh```, your old ```/etc/mongodb.conf``` (though it saves by timestamp like ```/etc/mongodb.conf.$TIMESTAMP.save```) and ```/etc/systemd/system/mongodb-server.service``` is replaced.

It install the required apt dependencies and generates the ```SystemD``` service, enables and starts.

It is for testing, you build it in Docker to test it, but the live building is on the server in the directory in the GIT repository ```build``` directory and then it puts the files into ```/usr/bin```.

## Scripts

It can work without sudo, but the best if you are ```rooot```. Of course, you can check the ```code```, there is no ```harm``` for sure!

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
sudo ./scripts/build-server.sh r3.6.2
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
sudo ./scripts/build-tools.sh r3.6.2
```

### 3. Sometimes check the kernel


The command:
```bash
./scripts/check-kernel.sh
```

It the kernel have changed, it better to re-build the server and the tools.

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

[**P3X-DOCKER-DEBIAN-TESTING-MONGODB-STABLE**](https://pages.corifeus.com/docker-debian-testing-mongodb-stable) Build v3.6.119-68 

[![Like Corifeus @ Facebook](https://img.shields.io/badge/LIKE-Corifeus-3b5998.svg)](https://www.facebook.com/corifeus.software) [![Donate for Corifeus / P3X](https://img.shields.io/badge/Donate-Corifeus-003087.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=LFRV89WPRMMVE&lc=HU&item_name=Patrik%20Laszlo&item_number=patrikx3&currency_code=HUF&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHosted)  [![Contact Corifeus / P3X](https://img.shields.io/badge/Contact-P3X-ff9900.svg)](https://www.patrikx3.com/en/front/contact) 


 

[//]: #@corifeus-footer:end