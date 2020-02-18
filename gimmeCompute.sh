#create 1x1 dockervm on ubu1804 - config'd to spec
#takes around 5mins to provision
#joshhighet
printf "\n🔥 new droplet incoming 🔥️\n\n" | lolcat --animate --speed=60
doctl compute droplet create \
josh --size s-1vcpu-1gb \
--image docker-18-04 \
--enable-ipv6 \
--region nyc1 \
--ssh-keys 1a:5e:b4:3e:04:5d:65:59:e6:a0:aa:87:6e:7e:0e:34 \
--format ID,Name,Memory,VCPUs,Disk,Region,Image | lolcat --animate --speed=5
printf "\n"
printf "🖥️  droplet  provisioning - standby 🖥️ \n\n" | lolcat --animate --speed=15
doctl compute droplet list \
--format PublicIPv4,PublicIPv6 | lolcat --animate --speed=60
printf "\n🎀 waiting for droplet to accept inbound connections 🎀\n\n" | lolcat --animate --speed=1
shelladdr=`doctl compute droplet list josh --format PublicIPv4 --no-header`
sleep 45
printf "⏰ init. custom provisioning - this will take a few mins ⏰\n\n" | lolcat --animate --speed=15
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -t \
root@$shelladdr "mkdir /tmp/j && git clone https://github.com/joshhighet/j.git /tmp/j --quiet && cd /tmp/j && chmod +x j.sh && ./j.sh"
printf "\n🏁 all done - droplet restarting - standby 🏁\n\n" | lolcat --animate --speed=15
sleep 35
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no josh@$shelladdr
printf "\n"
doctl compute droplet delete josh
