#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# start keychain daemon ('keychain' package)
mkdir -p /tmp/keychain
# install for x11 package `x11-ssh-askpass`
eval $(keychain --dir /tmp/keychain --eval --agents ssh -Q --quiet id_rsa)
