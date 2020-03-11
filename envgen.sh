#######################################################################
#                      LOCAL SECRETS GENERATION                       #
#######################################################################

echo GH_USER="$(git config --global user.name)" >> /tmp/env.txt
echo GH_EMAIL="$(git config --global user.email)" >> /tmp/env.txt
echo GH_TOKEN="$(cat ~/.ssh/github_token.txt)" >> /tmp/env.txt
echo ID_RSA="$(cat ~/.ssh/id_rsa)" >> /tmp/env.txt
echo ID_RSA_PUB="$(cat ~/.ssh/id_rsa.pub)" >> /tmp/env.txt
