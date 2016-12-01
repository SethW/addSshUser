#!/bin/bash
username=$1

if [ -n "${username}" ]; then
	
	if id "$username" >/dev/null 2>&1; then
		echo "User: $username already exists"
	else
		#User does not exist
		sudo adduser $username
		sudo sed -ie "s/AllowUsers/& $username/g" /etc/ssh/sshd_config
		sudo mkdir /home/"$username"/.ssh
		sudo chown $username:$username /home/"$username"/.ssh
		sudo systemctl restart ssh
	fi
else
	echo "Invalid Username"
fi
