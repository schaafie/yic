# entrypoint.sh
#!/bin/bash

# Docker entrypoint script.
# Wait until Postgres is ready
echo "Testing if Postgres is accepting connections. {$PGHOST} {$PGPORT} ${PGUSER}"
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER; do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# If database is not created, build the new database
# NOTE: Environment variables starting with PG are crucial for correct connection
echo ">>>> Checking database "
if [[ -z $(psql -Atqc "\list $PGDATABASE") ]]; then
  echo ">>>> Database $PGDATABASE does not exist. Creating..."
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  echo ">>>> Database $PGDATABASE created."
else
  echo ">>>> Database exists."
fi

echo ">>>> Done."

exec mix phx.server