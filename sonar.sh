
#!/bin/bash
# ------------------------------------------------------------------
# SonarQube Ubuntu Deployment Script (Requires t2.medium or larger)
# ------------------------------------------------------------------

# 1. Update system and install required system utilities
apt-get update -y
apt-get install unzip wget openjdk-11-jdk -y

# 2. Download and extract SonarQube to /opt/
cd /opt/
wget -c https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip
unzip -o sonarqube-8.9.6.50800.zip

# 3. Handle dedicated sonar user creation safely
if id "sonar" &>/dev/null; then
    echo "User 'sonar' already exists. Proceeding..."
else
    useradd -m -s /bin/bash sonar
fi

# 4. Correct directory permissions for security
chown -R sonar:sonar /opt/sonarqube-8.9.6.50800
chmod -R 755 /opt/sonarqube-8.9.6.50800

# 5. Start the SonarQube engine as the sonar user
echo "Starting SonarQube service..."
sudo -u sonar /opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh start

echo "--------------------------------------------------------"
echo "SonarQube installation initiated!"
echo "Default credentials -> Username: admin | Password: admin"
echo "--------------------------------------------------------"

chmod +x deploy_sonar.sh
sudo ./deploy_sonar.sh

sudo -u sonar /opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh status

