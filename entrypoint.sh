# entrypoint.sh

#!/bin/bash

# Docker entrypoint script.
# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER; do
  echo "$(date) - waiting for database to start"
  sleep 2
done

cd /yic/apps
# Find all directories in the apps folder
for APP in $(ls -d *); do
  cd $APP
  echo ">> Preparing ${APP}..."
  echo ">>>> Getting dependencies"
  mix deps.get
  echo ">>>> Checking database "
  # Build database name
  DBNAME="${APP}_dev"
  # Check if the App has a repo
  COUNT=$(find . -name repo.ex | wc -l)
  # If has a repo and database is not created, build the new database
  # NOTE: Environment variables starting with PG are crucial for correct connection
  if [[ $COUNT = 1 ]] && [[ -z $(psql -Atqc "\list $DBNAME") ]]; then
    echo ">>>> Database $DBNAME does not exist. Creating..."
    mix ecto.create
    mix ecto.migrate
    mix run priv/repo/seeds.exs
    echo ">>>> Database $DBNAME created."
  else
    echo ">>>> Database not needed or exists."
  fi

  echo ">>>> Done."
  cd ..
done

cd /yic
mix deps.get

exec mix phx.server
