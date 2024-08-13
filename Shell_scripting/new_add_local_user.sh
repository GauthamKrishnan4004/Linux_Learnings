#!/bin/bash

#check for root privileges
if [[ $UID -ne 0 ]]
then
	echo "please run with root privileges"
	exit 1
fi

if [[ ${#} -ne 2 ]] then
	echo "usage ${0} [USERNAME] [COMMENT] "
	exit 1
fi

USERNAME=${1}
COMMENT=${2}
PASSWORD=$(date +%s%N | sha256sum | head -c 10 )

if [[ ${?} -ne 0 ]]
then
	echo "password not created"
	exit 1
fi

echo "new user details"
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Comment: ${COMMENT}"
echo  "${PASSWORD}:${USERNAME}"

#echo "Enter the new login credentials for new User name"

#read -p "enter the Username: " USERNAME
#read -p "enter the Password: " PASSWORD
#read -p "enter the Actual name of the user: " COMMENT

useradd -c "${COMMENT}" -m ${USERNAME}
if [[ ${?} -ne 0 ]]
then
	echo "new user not created"
	exit 1
fi

echo  "${USERNAME}:${PASSWORD}" | chpasswd
if [[ ${?} -ne 0 ]]
then
	echo "new user password not created"
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

