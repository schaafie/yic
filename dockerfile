# ./Dockerfile
# Extend from the official Elixir image
FROM elixir:1.12.3

RUN apt-get update
RUN apt-get install -y build-essential inotify-tools postgresql-client git
RUN apt-get clean

# Create required directories
RUN mkdir /yic
WORKDIR /yic

# copy the Elixir files
COPY entrypoint.sh .
COPY mix.exs .
COPY mix.lock .

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile

# Run the entrypoint script
RUN ["chmod", "+x", "./entrypoint.sh"]
CMD ["bash","-c","./entrypoint.sh"] 