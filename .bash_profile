#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# start keychain daemon ('keychain' package)
mkdir -p /tmp/keychain
eval $(keychain --dir /tmp/keychain --eval --agents ssh -Q --quiet id_ecdsa id_rsa)
