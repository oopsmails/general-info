
# Python installation on ElementaryOS

## Using Virtual Env

- https://docs.python.org/3/tutorial/venv.html

- https://stackoverflow.com/questions/60044121/use-python-3-8-instead-of-3-6-on-elementary-os-or-ubuntu

I recommend you undo your symlink overwriting your systemwide version of Python 3. As you have found, replacing the python3 executable might create some problems, as it is used under the hood.

In general, you should leave your system python[3] installation alone for this reason and it is common to use virtual environments. This can be done as follows (assuming you are in some project directory):

python3.8 -m venv venv
source venv/bin/activate
The first command will create a virtual environment ('venv') in the directory venv. The second command will 'activate': now python (and in this case, python3 and python3.8) all refer to your original python3.8 in the context of this shell. You will have to repeat this if you launch a new shell.

This will also allow you to install packages using pip without cluttering your system installation. The use of virtual environments and pip is an incredibly common workflow in the Python development world.

In terms of shell and 'global' Python management, you can also use pyenv to manage your Python versions and what is available in the shell. pyenv is quite nice if you want to run a particular version of python, say 3.8.0 but not 3.8.1.


## Install directly

- https://exchangetimes.net/?p=496


In this article and the below video I show you how to install Python 3.7 the easy way on Elementary OS. This works on Pop_OS! and Ubuntu too.

1. Open a terminal
2. type and run: sudo apt update
3. type and run: sudo apt install software-properties-common
4. type and run: sudo add-apt-repository ppa:deadsnakes/ppa
5. Press Enter to add the above repository
6. type and run: sudo apt update
7. type and run: sudo apt install python3.7

You now have Python 3.7 installed


