#!/bin/bash

export MIX_ENV=prod
export PORT=5757
export NODEBIN=`pwd`/assets/node_modules/.bin
export PATH="$PATH:$NODEBIN"

echo "Building..."

mkdir -p ~/.config

mix deps.get
mix compile
(cd assets && npm install)
(cd assets && webpack --mode production)
mix phx.digest

echo "Generating release..."
mix release --env=prod


#echo "Stopping old copy of app, if any..."
#_build/prod/rel/task_tracker2/bin/task_tracker2 stop || true


echo "Starting app..."

_build/prod/rel/project/bin/project foreground
