# start keychain daemon ('keychain' package)
mkdir -p /tmp/keychain
# install for x11 package `x11-ssh-askpass`
eval $(SSH_ASKPASS=/usr/lib/ssh/ssh-askpass keychain --dir /tmp/keychain --eval --agents ssh -Q --quiet id_rsa)
