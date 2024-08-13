#!/bin/bash

if [[ $UID -ne 0 ]]
then
	echo "please run with root privileges"
	exit 1
fi

echo "Enter the new login credentials for new User name"

read -p "enter the Username: " USERNAME
read -p "enter the Password: " PASSWORD
read -p "enter the Actual name of the user: " COMMENT

useradd -c "${COMMENT}" -m ${USERNAME}
if [[ ${?} -ne 0 ]]
then
	echo "new user not created"
	exit 1
fi

echo  "${USERNAME}:${PASSWORD}" | /usr/sbin/chpasswd
if [[ ${?} -ne 0 ]]
then
	echo "new user not created"
	exit 1
fi


passwd -e ${USERNAME}
if [[ ${?} -ne 0 ]]
then
	echo "new user not created"
	exit 1
fi

echo "new user details"
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Comment: ${COMMENT}"

cat /etc/passwd

