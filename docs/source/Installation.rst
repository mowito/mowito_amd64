Setting up  mowito
=======================

User Registration
-------------------

Register yourself on this website https://mowito.in/register.html

Installing Mowito on Computer
------------------------------------------

1. Clone the repo in the home directory, using

``git clone -b melodic https://github.com/mowito/mowito_amd64.git``\ 

2. Remove any previous installation of Mowito stack (replace 'melodic'
   with your ros version) ``cd ~/mowito_amd64``\ 
   ``./remove_mowito.sh melodic``

3. Install the new Mowito stack ``./setup_mowito.sh melodic``