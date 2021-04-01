# ./Dockerfile
# Extend from the official Elixir image
FROM elixir:1.9.4

RUN apt-get update && \ 
   apt-get install -y postgresql-client

# Create required directories
RUN mkdir /yic
WORKDIR /yic
RUN mkdir /apps
RUN mkdir /config
RUN mkdir /deps

# Create database_host ENV for ecto
ENV DATABASE_HOST "db"

# copy the Elixir files
COPY entrypoint.sh .
COPY mix.exs .
COPY mix.lock .
COPY config config

RUN ["chmod", "+x", "./entrypoint.sh"]

# Install hex package manager
RUN mix local.hex --force && \
  mix local.rebar && \
  mix deps.get && \
  mix deps.compile

# Run the entrypoint script
CMD ["bash","-c","./entrypoint.sh"] 