ARG ELIXIR_VERSION=1.14.0
ARG ERLANG_VERSION=25.1
ARG ALPINE_VERSION=3.14.8

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${ERLANG_VERSION}-alpine-${ALPINE_VERSION}"
ARG RUNNER_IMAGE="alpine:3.14.8"

FROM ${BUILDER_IMAGE} AS build

RUN apk add --no-cache build-base git python3 curl

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV="prod"

COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

RUN mkdir config
COPY config/config.exs config/$MIX_ENV.exs config/
RUN mix deps.compile

COPY lib lib
RUN mix compile

COPY config/runtime.exs config/

RUN mix release

FROM ${RUNNER_IMAGE}

RUN apk add --no-cache libstdc++ openssl ncurses-libs imagemagick

ENV USER="elixir"

WORKDIR "/home/${USER}/app"

RUN \
  addgroup \
  -g 1000 \
  -S "${USER}" \
  && adduser \
  -s /bin/sh \
  -u 1000 \
  -G "${USER}" \
  -h "/home/${USER}" \
  -D "${USER}" \
  && su "${USER}"

RUN chown ${USER} /home/${USER}/app

RUN mkdir /home/${USER}/b3_files
RUN chown ${USER} /home/${USER}/b3_files

USER "${USER}"

ENV MIX_ENV="prod"

COPY --from=build --chown="${USER}":"${USER}" /app/_build/${MIX_ENV}/rel/b3 .

ENTRYPOINT ["bin/b3"]
