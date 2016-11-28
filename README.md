# seltzer-tonic-vagrant
Installation Instructions for Seltzer &amp; Tonic

Seltzer and Tonic are the two packages that comprise the Customer Relationship Management (CRM) system 
at the Tech Valley Center of Gravity. It is used to track memberships, payments, provide card access and
some metrics for use of the space. 

The Seltzer package is a fork of the open source Seltzer CRM whose main branch is found at 

     https://github.com/elplatt/seltzer

Tonic uses the Seltzer database as a shared resource to perform tasks not possible in Seltzer itself, such as automated billing, membership signup and matriculation, and card system management. 

To create a fully functional development environment to work on both Seltzer and Tonic, it is necessary to have Vagrant and all its dependencies installed. Once that is installed, the process for bringing up
the development environment is:


1.) Create a directory to be used as the vagrant shared directory, and place the supplied Vagrantfile in the directory. The host machine should be have NFS installed to allow this directory to be shared in the virtual machine created by Vagrant. Vagrant will make its best effort to do the NFS configuration automatically, both in the host machine and in the virtual machine. The vagrant shared directory will be mounted at /vagrant on the virtual machine.

2.) (Optional) Edit the Vagrantfile and make any needed changes to the configuration. The most common change is to change the IP address for the private network between the virtual machine and the host defined by "config.vm.network". The default is 192.168.14.27, but if you are using 192.168.14.xxx as a 
network already, change the IP to some unused block and make a note of the IP.

2.) Open a terminal window, cd to your vagrant shared directory and run:

 	vagrant up

3.) Once the provisioning process is complete, you will have a running instance of the virtual machine with Seltzer and Tonic running. You can connect to the machine using:

    vagrant ssh

4.) The Seltzer web site will be at http://((IP address set in config.vm.network))/crm/



The distribution has a number of default passwords installed that you may wish to change. Below are some quick guides on changing passwords from their defaults for security purposes:


MySQL passwords
---------------

The system comes preconfigured with a MySQL root password, and two users corresponding to the two packages: seltzer &amp; tonic. Below are the defaults:


		MySQL/MariaDB root password: r3wtSQLpass
		MySQL/MariaDB seltzer password: fizzyH2O
		MySQL/MariaDB tonic password: fizzyH2O

To change the Mysql root password, use:
		 
		mysqladmin -p -u root password MySecureNewPassword

To change the Mysql seltzer or tonic password:

		a.) Connect to mysql using:

				mysql -p -u root root

		b.) Use the following SQL command to update the password for the appropriate user:

				update user set password=PASSWORD('myAwesomeNewPassword') where User = 'seltzer';
				update user set password=PASSWORD('anotherAwesomePass') where User = 'tonic';

			and follow with

				 flush privileges;

		c.) If you changed the seltzer password, update the following files with the new password:

			/vagrant/packages/seltzer/config.inc.php 
			/vagrant/packages/tonic/config/seltzerCfg.py


Seltzer passwords
-----------------

To access the administrative functions of Seltzer through the web interface, you can use the default credentials:

		username: admin
		password: b1gC4huna!

The password for the admin account can be changed through the Seltzer web interface.




