# MultiVenv

_a modern replacement for virtualenvwrapper_

It is typical for Python projects to use a virtualenv stored in the root of the project. This is a tool that makes it easy to put them somewhere else.

## How It Works

It works almost the same as virtualenvs, except every venv is stored in `$MULTIVENV_HOME`, which defaults to `~/.multivenvs`. Once a venv is activated, they behave exactly the same way.


## How To Use It

Here are the commands.

| Command  | Description                        |
| -------- | ---------------------------------- |
| mkvenv   | make a new venv                    |
| usevenv  | enable a venv                      |
| stopvenv | alias for deactivate               |
| rmvenv   | delete a venv                      |
| lsvenvs  | list your venvs                    |
| cdvenv   | go to the directory root of a venv |

Creating a new venv:

```bash
$ mkdir new_project && cd new_project

$ mkvenv proj_env     # Automatically activates venv

(proj_env)$ pip install numpy pandas matplotlib jupyter
Successfully installed ...

(proj_env)$ which jupyter
/home/jmsdnns/.multivenv/proj_env/bin/jupyter
```

Using an existing venv:

```bash
$ usevenv proj_env    # Activate venv

(proj_env)$ python your_script.py


(proj_env)$ stopvenv  # Deactivate venv

$
```

Managing your venvs:

```bash
$ lsvenvs
maestral
mathhomework
proj_env

$ cdvenv proj_env

$ pwd
/home/jmsdnns/.multivenv/proj_env

$ rmvenv proj_env
Are you sure? [y/N] y

$ lsvenvs
maestral
mathhomework
```

## How To Install It

Download a copy of [multienv.sh](multivenv.sh) and source it in your shell.

```
$ curl -O https://raw.githubusercontent.com/jmsdnns/multivenv/main/multivenv.sh
$ source multivenv.sh
```

Or, clone the repo and source the file in your `.bashrc`.

```
$ git clone https://github.com/jmsdnns/multivenv
$ echo "source $PWD/multivenv/multivenv.sh" >> .bashrc
```
