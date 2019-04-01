
# SETUP VAGRANT FILE
- Copy Vagrantfile to your dest.
- install Vagrant
- install VirtualBox (VM provider)

- - vagrant up
- - vagrant ssh
- - vagrant halt (to shut it down)
- - (vagrant destroy to start fresh !!)

- > uname -r: 3.2.0-23-generic

# INSTALL GCC 4.8

# link: http://askubuntu.com/questions/271388/how-to-install-gcc-4-8?newreg=6c2b1c109685438c8bc7b37a87cefb21

# Open a terminal(Ctrl+Alt+t) and run the following commands:
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update

# install gcc
sudo apt-get install gcc-4.8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50

# install g++
sudo apt-get install g++-4.8
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50

# check gcc and g++ version
gcc --version


# SETUP ZSIM

- Change the ROOT parameter in bashrc file

- Working directories are:

- - vagrant@precise64:/home/user_name$
- - - Tools
- - - Work
- - - - pin
- - - - project_name
- - - - - zsim
...



