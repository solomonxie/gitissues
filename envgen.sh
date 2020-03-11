#######################################################################
#                      LOCAL SECRETS GENERATION                       #
#######################################################################

export GH_USER="$(git config --global user.name)"
export GH_EMAIL="$(git config --global user.email)"
export GH_TOKEN="$(cat ~/.ssh/github_token.txt)"
export ID_RSA="$(cat ~/.ssh/id_rsa)"
export ID_RSA_PUB="$(cat ~/.ssh/id_rsa.pub)"
