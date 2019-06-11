#!/bin/bash

# set parameter
GATEWAYIP=$1

# set gateway
echo "default gateway = ${GATEWAYIP}"
sudo route add default gw ${GATEWAYIP}

echo "#!/bin/bash" | sudo tee /etc/network/if-up.d/99route
echo "route add default gw ${GATEWAYIP}" | sudo tee -a /etc/network/if-up.d/99route
sudo chmod 755 /etc/network/if-up.d/99route
