# 1. Update your Ubuntu package repository and install Java 11 (required for SonarQube 8.9)
sudo apt update -y && sudo apt install openjdk-11-jdk -y

# 2. Create the dedicated 'sonar' system user account
sudo useradd -r -s /bin/bash sonar

# 3. Securely transfer ownership of the extracted directory to the 'sonar' user
sudo chown -R sonar:sonar /opt/sonarqube-8.9.6.50800

# 4. Set secure read/write/execute permissions (Avoid 777, as it causes system crashes)
sudo chmod -R 755 /opt/sonarqube-8.9.6.50800

# 5. Switch shell context over to your newly created sonar user
sudo su - sonar
