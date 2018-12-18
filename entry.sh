#!/bin/sh
uid=`stat -c '%u' /home/user`
if [ $uid -eq 0 ]; then
	echo "workdir must not be owned by root."
	exit 1
fi

install -m 4755 /export/node_modules/puppeteer/.local-chromium/linux-*/chrome-linux/chrome_sandbox /usr/local/sbin/chrome_sandbox
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome_sandbox

# create resume user with matching id
userdel `id -nu $uid`
useradd -d /home/user -u $uid resume
# and drop privileges
sudo -u resume -- env RESUME_PUPPETEER_NO_SANDBOX=1 CHROME_DEVEL_SANDBOX="$CHROME_DEVEL_SANDBOX" nodejs /export/node_modules/resume-cli/index.js "$@"
