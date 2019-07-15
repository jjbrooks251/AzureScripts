echo "do you want docker on your vm? [y/n]"
read optd

echo "do you want jenkins on your vm? [y/n]"
read optj

echo "do you want maven on your vm? [y/n]"
read optm

touch runme.sh
chmod +x ./runme.sh

if [ $optd = y ]
then
	chmod +x /home/${whoami}/scripts/install/docker.sh
	scp /home/${whoami}/scripts/install/docker.sh ${whoami}@${ip}:/home/${whoami}
	chmod -x /home/${whoami}/scripts/install/docker.sh
fi

if [ $optj = y ]
then
	chmod +x /home/${whoami}/scripts/jenkins.sh
	scp /home/${whoami}/scripts/jenkins.sh ${whoami}@${ip}:/home/${whoami}
	chmod -x /home/${whoami}/scripts/jenkins.sh
fi

if [ $optm = y ]
then
	chmod +x /home/${whoami}/scripts/maven.sh
	scp /home/${whoami}/scripts/maven.sh ${whoami}@${ip}:/home/${whoami}
	chmod -x /home/${whoami}/scripts/maven.sh
fi

scp ./runme.sh ${whoami}@${ip}:/home/${whoami}

ssh ${whoami}@${ip}
