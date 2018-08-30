# Motherbase saltstack states

This is the bootstrap of the GCP enviroment. This repo is for deploying the core which we can consider to be the control plane.
This currently runs on VM's however containers are a consideration. We intend to deploy this using terraform and manage the orchestration process.

## Services
We are attempting to deploy a number of diffirent services using salt stack. One the main services we intend to deploy is salt-master. We are currenlty testing locally using vagrant.
We intend to deploy the salt master alongside consul and vault. These things should esentailly work together. The salt stack master should use consul a job cache, vault as secrets store and
postgres as job status store. The so called salt mine will also be located inside the consul servie.

We have choosen to deploy alongside this service because it will permit us to scale it out and create syndicates more easily. We have configured the module grab configuration information from
the a remote git repository. This is currently configurable.

## PKI

This should generally be the PKI core. Vault should be configured to use intermidiate CA certificate. GPG should the method used when distributing secret generated during the bootstrap process.
The signing policy defines what can be signed for what and how it can be signed. This needs to be refined however as there is currently no security policies it is hard to deifne.
Current the initial web server certificates are generated from this system.

We can store the config inside GCP KMS backend as defined in the following [blog and module](https://cloud.google.com/solutions/using-vault-for-secret-management)

## Local testing 

In order to locally test this you can use vagrant to spin an enviroment in which the test run. You will need the pillar configured to your required standard.

You spin up the machine using vagrant. Go to the repositry and run the following command:
   `vagrant up`
   
Once the machine is up you need to login using the following:
    `vagrant ssh` 
    
Once you are logged in please sudo and run the following:
    `sudo su`
    `salt-call --local --pillar-root=/srv/pillar --states-dir=/srv/salt state.apply`

You will need to run this command three times as there are issue's with the dependencies tree.

Once you have all test passing you can accept the ssh key and run salt from the master. Everything should then be connected and salt will use consul and postgres.
Vault is also accessible how you will need to manually boostrap the vault cluster backed by consul or GCP storage.