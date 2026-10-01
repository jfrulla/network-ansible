# Using Pipenv/PyEnv to manage python version and packages using Git

__PyEnv__ - A Python-based tool for managing install Python excutable sets. This allows for detachement from the normally version-locked variants provided by the distro pacakge manager, instead providing pre-compiled versions provided by the Python.org team.

__PDM (Python Development Manager)__ - A Python-based tool for managing Python package manager "Pip" dependency lists that may change based on OS used, including Windows, Mac, and Linux disros. This tool does not create a virtualenv, instead loading libraries on run.

### Getting up and running with Pipenv in 4 steps

1. Install Python3 and Python3-pip on your local system.

    ```bash
    yum update
    yum install python3 python3-pip \
    git curl gcc make \
    zlib zlib zlib-devel \
    libffi libffi-devel \
    tcl tcl-devel \
    readline readline-devel \
    tcl tcl-devel \
    tk tk-devel \
    openssl openssl-devel \
    bzip2 bzip2-libs bzip2-devel \
    sqlite sqlite-libs sqlite-devel
    ```

2. Install pyenv to the system Python packages

    ```bash
    curl https://pyenv.run | bash
    cat >> ~/.bashrc <<EOL
    export PATH="/root/.pyenv/bin:\$PATH"
    eval "\$(pyenv init -)"
    eval "\$(pyenv virtualenv-init -)"
    EOL
    ```

3. Install PDM to your local user Pip

    ```bash
    python3 -m pip install pdm
    ```

4. Use PDM to pull/install packages locally.

    ```bash
    cd /PATH/WHERE/MY/PDM/TOML/FILE/IS
    pdm lock
    pdm install
    ```

5. Execute code using your new PDM environment
    ```bash
    pdm run 'python3 my_command.py'
    ```

### Updating the pdm listed packages

```bash
pdm lock
pdm install
```

### Adding a package to the `pyproject.toml` file (using pdm)

```bash
pdm add my_package
```

### Initializing a PDM project

1. Run `pdm init` and follow the steps requested. Make sure to have prepared your python interpreter before hand using pyenv.

```
pdm init

Creating a pyproject.toml for PDM...
Please enter the Python interpreter to use
0. /usr/bin/python (2.7)
1. /Users/user_sanitized/.pyenv/versions/3.9.5/bin/python3 (3.9)
2. /usr/local/bin/python3 (3.9)
3. /usr/local/bin/python3.9 (3.9)
4. /usr/bin/python3 (3.8)
5. /usr/bin/python2 (2.7)
6. /usr/bin/pythonw (2.7)
7. /usr/bin/python2.7 (2.7)
8. /usr/local/Cellar/python@3.9/3.9.1_8/bin/python3.9 (3.9)
Please select: [0]: 1
Using Python interpreter: /Users/user_sanitized/.pyenv/versions/3.9.5/bin/python3 (3.9)
Is the project a library that will be upload to PyPI? [y/N]: N
License(SPDX name) [MIT]: MIT
Author name [User Sanitized]: UW Research Computing
Author email [user_sanitized@example.edu]: user_sanitized@example.edu
Python requires('*' to allow any) [>=3.9]:
Changes are written to pyproject.toml.
Found following files from other formats that you may import:
0. /Users/user_sanitized/dev/klone-python/Pipfile (pipfile)
1. don't do anything, I will import later.
```
