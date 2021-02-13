[//]: #@corifeus-header

 

[![Donate for Corifeus / P3X](https://img.shields.io/badge/Donate-Corifeus-003087.svg)](https://paypal.me/patrikx3) [![Contact Corifeus / P3X](https://img.shields.io/badge/Contact-P3X-ff9900.svg)](https://www.patrikx3.com/en/front/contact) [![Corifeus @ Facebook](https://img.shields.io/badge/Facebook-Corifeus-3b5998.svg)](https://www.facebook.com/corifeus.software)   [![Build Status](https://github.com/patrikx3/docker-debian-testing-mongodb-stable/workflows/nodejs/badge.svg)](https://github.com/patrikx3/docker-debian-testing-mongodb-stable/actions?query=workflow%3Anodejs)
[![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m780749701-41bcade28c1ea8154eda7cca.svg)](https://uptimerobot.patrikx3.com/)

# ✨ Debian Bullseye / Bookworm / Testing / SID MongoDB and MongoDB Tools build stable 


                        
[//]: #@corifeus-header:end

It is basically a built for the latest MongoDB for Debian.
  
This is for `x64` only.
  
The current version is the r4.4.1 build (https://docs.mongodb.com/manual/release-notes/).

There is a newer version `4.5.0`, but given, we use `NoSQLBooster`, it only works with `4.4.1` and the `4.4.x` is the stable, the next stable will be `4.6.0`, `4.8.0` and so on...


## Scripts for building

It can work with `sudo`, but the best if you are ```root```. Of course, you can check the ```code```, there is no ```harm``` for sure!

```bash
git clone https://github.com/patrikx3/docker-debian-testing-mongodb-stable
cd docker-debian-testing-mongodb-stable
```

It downloads the specified version and deploy on your server. 

### 1. Build MongoDB Server
First stop the database server.

The command:
```bash
sudo ./scripts/build-server.sh 4.4.3
```

All defaults are in the config, that MongoDB uses:  
* /var/log/mongodb - log
* /var/lib/mongodb - data

It generates everything, all you have to do as the script says.

Now, you can start again the MongoDB server.

### 2. Build MongoDB Tools

The command:
```bash
./scripts/build-tools.sh
```

It generates and install GoLang and builds the tools that you find them in:    
https://github.com/mongodb/mongo-tools

Then, it puts all tools into the default Debian ```/usr/bin``` directories.

The exact command is like:
```bash
sudo ./scripts/build-tools.sh r4.3.2
```

### 3. Start the services

Before you start the database, **but after the build** , you are required to create a config (unless, you already have it), a skeleton is here:  
```text
artifacts/root-filesystem/etc/mongodb.conf
```


#### Add safety to the mongodb config file

```bash
sudo cp ./artifacts/root-filesystem/etc/mongodb.conf /etc/mongodb.conf
sudo chmod o-rwx /etc/mongodb.conf
sudo chown mongodb:mongodb /etc/mongodb.conf
```

After you created the config, you start the database like:  
```service mongodb-server start``` or ```service mongodb-server restart```



<!---

### 3. Sometimes check the kernel


The command:
```bash
./scripts/check-kernel.sh
```

It the kernel have changed, it better to re-build the server and the tools.

Right now the stable MongoDB 4.0.0 doesn't show the kernel version anymore

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

🙏 This is an open-source project. Star this repository, if you like it, or even donate to maintain the servers and the development. Thank you so much!

Possible, this server, rarely, is down, please, hang on for 15-30 minutes and the server will be back up.

All my domains ([patrikx3.com](https://patrikx3.com) and [corifeus.com](https://corifeus.com)) could have minor errors, since I am developing in my free time. However, it is usually stable.

**Note about versioning:** Versions are cut in Major.Minor.Patch schema. Major is always the current year. Minor is either 4 (January - June) or 10 (July - December). Patch is incremental by every build. If there is a breaking change, it should be noted in the readme.


---

[**P3X-DOCKER-DEBIAN-TESTING-MONGODB-STABLE**](https://corifeus.com/docker-debian-testing-mongodb-stable) Build v2021.4.103

[![Donate for Corifeus / P3X](https://img.shields.io/badge/Donate-Corifeus-003087.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QZVM4V6HVZJW6)  [![Contact Corifeus / P3X](https://img.shields.io/badge/Contact-P3X-ff9900.svg)](https://www.patrikx3.com/en/front/contact) [![Like Corifeus @ Facebook](https://img.shields.io/badge/LIKE-Corifeus-3b5998.svg)](https://www.facebook.com/corifeus.software)


## P3X Sponsor

[IntelliJ - The most intelligent Java IDE](https://www.jetbrains.com/?from=patrikx3)

[![JetBrains](https://cdn.corifeus.com/assets/svg/jetbrains-logo.svg)](https://www.jetbrains.com/?from=patrikx3)




[//]: #@corifeus-footer:end
