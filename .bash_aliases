base64e() {
    echo "$1" | base64
}

base64d() {
    echo "$1" | base64 -d
}

hex() {
    echo "$1" | xxd -p
}

hexd() {
    echo "$1" | xxd -p -r
}

rot13() {
    echo "$1" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

scannet() {
    sudo nmap "$1" -sn | grep for | cut -d" " -f5
}

scanip() {
    if [ "$2" ]; then
        sudo nmap -sV -sC "$1" -oA "$2"
    else
        sudo nmap -sV -sC "$1"
    fi
}
run() {
  setsid "$@" < /dev/null > /dev/null 2>&1
}

venv() {
    local env_name=$1
    if [[ -z "$env_name" ]]; then
        echo "Usage: activate_env <environment_name>"
        return 1
    fi

    local env_path="$HOME/.venvs/$env_name/bin/activate"
    if [[ -f "$env_path" ]]; then
        source "$env_path"
    else
        echo "Environment '$env_name' not found in ~/.venvs"
        return 1
    fi
}

upload() {
    local file_name=$1
    if [[ -z "$file_name" ]]; then
        echo "Usage: to_server <file_to_upload_name>"
        return 1
    fi

    local scp_path="house:/home/ubuntu/shared/$file_name"
    scp "$file_name" "$scp_path"
}

download() {
    local file_name=$1
    if [[ -z "$file_name" ]]; then
        echo "Usage: from_server <file_to_download_name>"
        return 1
    fi

    local scp_path="house:/home/ubuntu/shared/$file_name"
    scp "$scp_path" "$file_name"
}

alias updt='sudo sh -c "apt-get update; apt-get -y dist-upgrade"'
export PATH=/usr/local/cuda-12.6/bin${PATH:+:${PATH}}
alias python=python3