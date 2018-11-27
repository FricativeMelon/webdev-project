
#!/bin/bash

export MIX_ENV=prod
export PORT=5757

echo "Stopping old copy of app, if any..."

_build/prod/rel/project/bin/project stop || true

echo "Starting app..."

# TODO: You want start.

_build/prod/rel/project/bin/project start

# TODO: Add a cron rule or systemd service file
#   
