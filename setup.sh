echo "Setting up the environment"

echo "Set up Docker"

apt update
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/raspbian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/raspbian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker set up"

# configure your Raspberry Pi to automatically run the Docker system service, whenever it boots up
sudo systemctl enable docker


# set up automatic backup cronjob
echo "Set up cron job"

  # Define variables
CRONJOB="0 0/12 * * * sh ~/Projects/ng-server-settings/backup.sh"

  # Check if cron job already exists
if ! crontab -l | grep -qF "$CRONJOB"; then
    # Add cron job to crontab
    (crontab -l 2>/dev/null; echo "$CRONJOB") | crontab -
    echo "Cron job added to crontab."
else
    echo "Cron job already exists in crontab."
fi

# In order to start running services, we need to set up environment variables.
# We need to add these lines to the end of .profile file
# export POSTGRES_USER=
# export POSTGRES_PASSWORD=
# export POSTGRES_DB=
# we can edit the file with command nano ~/.profile

echo "Run services"

# start the Docker service
docker compose up -d

echo "Services running"