#!/bin/bash

# Create user and include to the sudoers
# username=ricardo
# password=BrasaJava2014

# sudo useradd -d /home/${username} -m -c"comments" -s /bin/bash ${username}
# # edit with visudo
# sudo passwd ${username}

# sudo su - ${username}

# # Install GIT edit with vi
# git_repo="[wandisco-git]
#     name=Wandisco GIT Repository
#     baseurl=http://opensource.wandisco.com/centos/7/git/$basearch/
#     enabled=1
#     gpgcheck=1
#     gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco"
# sudo echo ${git_repo} > /etc/yum.repos.d/wandisco-git.repo
# sudo rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
# sudo yum install git -y

basedir=/home/ricardo
source=${basedir}/source
server=${basedir}/server
setupdir=${basedir}/setupdir

mkdir -p ${source}
mkdir -p ${server}

cd ${source}
git clone https://code.tmdn.org/incubator/rpa-rest-service.git

# Install Java-8
sudo yum install java-1.8.0-openjdk-devel.x86_64

cd ${setupdir}
tar -xzvf mysql-5.6.51-linux-glibc2.12-x86_64.tar.gz -C ${server}/mysql
tar -xzvf elasticsearch-2.4.1.tar.gz -C ${server}/elastic
tar -xzvf wildfly-10.1.0.Final.tar.gz -C ${server}/wildfly
tar -xzvf mule-standalone-3.8.1-20210217.tar.gz -C ${server}/mule

tar -xzvf BackOffice.tar.gz -C ${source}



# Install Maven 3.3.9
wget https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz -P /tmp
sudo tar xzf /tmp/apache-maven-3.3.9-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.3.9 /opt/maven
# sudo echo export JAVA_HOME=$(alternatives --list |grep java_sdk_openjdk | awk '{print $3}'); export M2_HOME=/opt/maven; export MAVEN_HOME=/opt/maven; export PATH=${M2_HOME}/bin:${PATH} > /etc/profile.d/maven.sh
sudo cp ${setupdir}/maven.sh /etc/profile.d/maven.sh
sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh




# ROBOT CONFIGURATION
# Install some prerequisites libraries
sudo yum update -y 
udo yum install wget gcc openssl-devel bzip2-devel libffi-devel unzip curl -y

# Install python-3.8.10
sudo wget -O /opt/Python-3.8.10.tgz https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz
cd /opt
sudo tar xzf Python-3.8.10.tgz
sudo rm Python-3.8.10.tgz
cd Python-3.8.10
sudo ./configure --enable-optimizations
sudo make altinstall

# Install wkhtmltopdf on CentOS
sudo wget -O /opt/wkhtmltox-0.12.6-1.centos7.x86_64.rpm wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox-0.12.6-1.centos7.x86_64.rpm
cd /opt
sudo yum localinstall wkhtmltox-0.12.6-1.centos7.x86_64.rpm
sudo rm /opt/wkhtmltox-0.12.6-1.centos7.x86_64.rpm

# Install google chrome on CentOS
sudo wget -O /opt/google-chrome-stable_current_x86_64.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
cd /opt
sudo yum localinstall google-chrome-stable_current_x86_64.rpm
sudo rm /opt/google-chrome-stable_current_x86_64.rpm

# Install Google Chrome Driver
read -a strarr <<< $(/opt/google/chrome/chrome -version);GOOGLE_CHROME_VERSION=${strarr[2]}
sudo wget -O /opt/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$GOOGLE_CHROME_VERSION/chromedriver_linux64.zip
sudo unzip /opt/chromedriver_linux64.zip -d /opt
sudo rm /opt/chromedriver_linux64.zip
sudo mv -f /opt/chromedriver /usr/local/bin/chromedriver
sudo chown root:root /usr/local/bin/chromedriver
sudo chmod 0755 /usr/local/bin/chromedriver        

# Create a virtual environment
python3.8 -m venv .env

# Install the required python libraries
source .env/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
pip install flask==2.0.2

# Configure the display on CentOS server
sudo yum install xorg-x11-server-Xvfb

# Install Selenium grid on CentOS server
sudo yum install java-1.8.0-openjdk
sudo wget -O /opt/selenium-server-4.1.2.jar https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.1.0/selenium-server-4.1.2.jar
sudo chmod +x /opt/selenium-server-4.1.2.jar 
java -jar /opt/selenium-server-4.1.2.jar hub &
java -jar /opt/selenium-server-4.1.2.jar node &
