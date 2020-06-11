################################################################################
USER=josh
EXTIP=`curl -s ipinfo.io/ip`
SSHKEYLOC=cdn.joshhighet.com/ssh
PASS=`date +%s | shasum -a 512 | base64 | head -c 15 ; echo`
################################################################################
adduser $USER --gecos \
"First Last,RoomNumber,WorkPhone,HomePhone" \
--disabled-password
echo "$USER:$PASS" | chpasswd
mkdir -p /home/$USER/.ssh
curl -L $SSHKEYLOC \
| tee /home/$USER/.ssh/authorized_keys
chown -R $USER:$USER /home/$USER
usermod -aG sudo $USER
printf 'cmd: ssh '$USER'@'$EXTIP''\\n
printf 'pass: '$PASS\\n
################################################################################
