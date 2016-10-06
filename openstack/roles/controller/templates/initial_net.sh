 neutron net-create ext-net --router:external --provider:physical_network external --provider:network_type flat
 neutron subnet-create ext-net 192.168.50.0/24 --name ext-subnet  --allocation-pool start=192.168.50.100,end=192.168.50.150 --disable-dhcp --gateway 192.168.50.1
neutron net-create demo-net
neutron subnet-create demo-net 192.168.1.0/24 --name demo-subnet --dns-nameserver 4.2.2.2 --gateway 192.168.1.1
neutron router-create demo-router
neutron router-interface-add demo-router demo-subnet
neutron router-gateway-set demo-router ext-net
