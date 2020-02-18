#create 1x1 dockervm on ubu1804 - config'd to spec
#takes around 5mins to provision
#joshhighet
printf "\n🔥 new droplet incoming 🔥️\n\n" | lolcat
doctl compute droplet create \
josh --size s-1vcpu-1gb \
--image docker-18-04 \
--enable-ipv6 \
--region nyc1 \
--ssh-keys 1a:5e:b4:3e:04:5d:65:59:e6:a0:aa:87:6e:7e:0e:34 \
--format ID,Name,Memory,VCPUs,Disk,Region,Image
printf "\n"
sleep 10
printf "🖥️  droplet  provisioning - standby 🖥️ \n\n" | lolcat
doctl compute droplet list \
--format PublicIPv4,PublicIPv6
shelladdr=`doctl compute droplet list josh --format PublicIPv4 --no-header`
printf "\n🎀 waiting 60 seconds for droplet to accept inbound connections 🎀\n\n" | lolcat
sleep 60
#while ! ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -t root@$shelladdr
#do
#  sleep 5
#done
printf "⏰ init. custom provisioning - this will take a few mins ⏰\n\n" | lolcat
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -t \
root@$shelladdr "mkdir /tmp/j && git clone https://github.com/joshhighet/j.git /tmp/j --quiet && cd /tmp/j && chmod +x j.sh && ./j.sh"
printf "\n🏁 all done - droplet restarting - standby 🏁\n\n" | lolcat
sleep 20
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no josh@$shelladdr
printf "\n"
doctl compute droplet delete josh
