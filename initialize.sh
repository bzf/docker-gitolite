#!/bin/bash

SSH_KEY=`printenv SSH_KEY`

if [[ -n $SSH_KEY ]]; then
  echo "Got SSH key, running 'gitolite setup'..."

  # Create a file with the public key
  echo $SSH_KEY > /home/git/admin.pub
  chown -R git /home/git/admin.pub

  # Run the setup as the `git` user
  runuser -l git -c './gitolite setup -pk ~/admin.pub' || exit 1
fi

# Start the `ssh` daemon
echo "Launching sshd..."
/usr/sbin/sshd -D
