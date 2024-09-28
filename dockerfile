# ./Dockerfile
# Extend from the official Elixir image
# docker pull bitwalker/alpine-elixir-phoenix:1.12.3
FROM elixir:1.12.3

RUN apt-get update
RUN apt-get install -y build-essential inotify-tools postgresql-client git
RUN apt-get clean

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force

# Create required directories
RUN mkdir /yic
WORKDIR /yic

