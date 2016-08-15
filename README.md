# openstack-ansible
openstack kilo installation on Ubuntu 14.04 

This ansible code is for openstack kilo installation ( Ubuntu)  , equivalent official manual steps are available in http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_overview.html

Extra modules :  This code uses extra module to manage openstack commands . https://github.com/openstack-ansible/openstack-ansible-modules

Lab scenarios :

Server type - VM ( vitual box):
Number of Nodes: 3 (vm) + 1 base machine  with ansible CM
* controller - 3GB ram , 1 network card ( 10.0.0.11) for management , 20GB HD 
* Neutron - 2 GB , 3 Network card ( eth0- 10.0.0.12 , eth1 -10.0.1.12 , eth2 - ext-tun)
* Compute - 3 GB , 2core processor , 20 GB HD , 2 network card (eth0 10.0.0.13 , eth1- 10.0.1.13)
    
Private Network : 192.168.1.0/24
Externel network : 192.168.50.0/24 

Vbox Nic configuration :
     * create 3 "host only network" vbox0- 10.0.0.1/24  vbox1-10.0.1.1/24  vbox1- 192.168.50.1/24
     
Deatiled Network configuration & system requirement  is available in :  http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_basic_environment.html

How to excute ansible code :
* download extra modules in base machine /usr/share/my_modules/ & update the ansible.cfg  "library=/usr/share/my_modules/"
* create host entry for all 4 hosts as below .
       *  10.0.0.11      	controller
       *  10.0.0.12       neutron
       * 10.0.0.13       compute
       * 10.0.0.111     ansible
      * clone this "openstack-ansible" to your base machine 
      * update the ansible host file as below .
              * controller
              * neutron
              *compute 
      * add ssh-key access to all three host from ansible MC        
      * cd openstack ; ansible-playbook  site.yml  -
      
:) Hope all good  till this step .

After sucessfull  installation , auth key is available in /root/openstack.rc  & we can source this and run further openstack management commands .

Sample Initial Network configuration :

* neutron net-create ext-net --router:external --provider:physical_network external --provider:network_type flat
*  neutron subnet-create ext-net 192.168.50.0/24 --name ext-subnet  --allocation-pool start=192.168.50.100,end=192.168.50.150 --disable-dhcp --gateway 192.168.50.1
* neutron net-create demo-net
* neutron subnet-create demo-net 192.168.1.0/24 --name demo-subnet --dns-nameserver 4.2.2.2 --gateway 192.168.1.1
* neutron router-create demo-router
* neutron router-interface-add demo-router demo-subnet
* neutron router-gateway-set demo-router ext-net

Note :
   Since all 3 VM's are chosen with host only adapter , the host may not get internet access . To over come  that you can run source NAT on base machine .
   Ex: sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE  
   For Further quries reach me : venkatesun@gmail.com




