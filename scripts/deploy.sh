#!/usr/bin/env bash

set -eu

if [ "${#}" -ne 1 ]; then
    echo "Usage: ${0} <user@server>"
    exit 1
fi

server=${1}

# use rsync to copy needed files
echo "Transferring files to ${server}"
rsync -a --relative \
--exclude "*.pyc" \
--exclude "nasearch/settings/__init__.py" \
--exclude "whoosh_index" \
--exclude ".git" \
--exclude ".gitignore" \
--exclude "*.opml" \
--exclude "*.fuse*" \
--exclude "*.sublime-*" \
--exclude "scripts/" \
--exclude "deploy/" \
--exclude "todo.txt" \
. ${server}:~/venv/noagenda-db/noagenda-db/

command="source ~/venv/noagenda-db/bin/activate &&"
command+="cd ~/venv/noagenda-db/noagenda-db &&"
command+="pip install -r requirements.txt &&"
command+="python manage.py migrate &&"
command+="python manage.py collectstatic --noinput &&"
command+="./bin/reload-server"
ssh ${server} ${command} &&
echo "Deploy complete"
