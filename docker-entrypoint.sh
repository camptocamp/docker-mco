# Convert public key to PKCS1
ssh-keygen -f ~/.ssh/id_rsa.pub -e -m pem > ~/.ssh/${MCO_USER}.pem

mco $@
