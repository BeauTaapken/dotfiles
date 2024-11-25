set -e

if [ ! -f ~/.ssh/.env ]; then
    echo "Error: ~/.ssh/.env file not found"
    exit 1
fi

set -o allexport
source ~/.ssh/.env
set +o allexport

envsubst < ~/.ssh/ssh_config.template > ~/.ssh/config

chmod 600 ~/.ssh/config

echo "SSH configuration has been generated successfully"
