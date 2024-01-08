# Multi Venv

export MULTIVENV_HOME=$HOME/.multivenv
export MULTIVENV_PYTHON="python3"

function _multivenv_verify() {
    if [[ ! -d $MULTIVENV_HOME ]]; then
        mkdir $MULTIVENV_HOME
    fi

    export MULTIVENV_HOME=$(realpath $MULTIVENV_HOME)
}

function usevenv() {
    _multivenv_verify

    if [[ ! -d $MULTIVENV_HOME/$1 ]]; then
        echo "ERROR: venv does not exist"
        return 1
    fi

    source $MULTIVENV_HOME/$1/bin/activate
}

function stopvenv() {
    _multivenv_verify

    if [[ -z $VIRTUAL_ENV ]]; then
        echo "ERROR: no active venv found"
        return 1
    fi

    deactivate
}

function mkvenv() {
    _multivenv_verify

    if [[ -z $1 ]]; then
        echo "ERROR: No venv name given"
        return 1
    fi

    if [[ -d $MULTIVENV_HOME/$1 ]]; then
        echo "ERROR: venv name already in use"
        return 1
    fi

    $MULTIVENV_PYTHON -mvenv $MULTIVENV_HOME/$1
    source $MULTIVENV_HOME/$1/bin/activate
}

function rmvenv() {
    _multivenv_verify

    if [[ -z $1 ]]; then
        echo "ERROR: No venv name given"
        return 1
    fi

    if [[ ! -d $MULTIVENV_HOME/$1 ]]; then
        echo "ERROR: venv does not exist"
        return 1
    fi

    if [[ $VIRTUAL_ENV == $MULTIVENV_HOME/$1 ]]; then
        echo "ERROR: cannot remove activate venv"
        return 1
    fi

    read -r -p "Are you sure? [y/N] " response
    # response=${response,,} # tolower
    response=$(echo $response | tr '[:upper:]' '[:lower:]')
    if [[ "$response" =~ ^(yes|y)$ ]]; then
        declare PRIOR_DIR=$(pwd)
        cd $MULTIVENV_HOME
        rm -rf $1

        if [[ -d $PRIOR_DIR ]]; then
            cd $PRIOR_DIR
        fi
    fi
}

function lsvenvs() {
    _multivenv_verify

    for FILE in $(ls $MULTIVENV_HOME); do
        echo $FILE
    done
}

function cdvenv() {
    _multivenv_verify

    if [[ -z $1 ]]; then
        echo "ERROR: No venv name given"
        return 1
    fi

    if [[ ! -d $MULTIVENV_HOME/$1 ]]; then
        echo "ERROR: venv does not exist"
        return 1
    fi

    cd $MULTIVENV_HOME/$1
}

# tab completions

function _listvenvs() {
    local cur
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($( compgen -W "$(\ls $MULTIVENV_HOME)" -- $cur ) )
}

complete -F _listvenvs usevenv
complete -F _listvenvs rmvenv
complete -F _listvenvs cdvenv
