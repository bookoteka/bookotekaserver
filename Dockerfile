# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.4.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Instalacja podstawowych pakietów uruchomieniowych dla produkcji
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl \
      libjemalloc2 \
      libvips \
      sqlite3 \
      chromium \
      fonts-liberation \
      fonts-dejavu-core \
      nodejs \
      npm && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so" \
    GROVER_CHROMIUM_PATH="/usr/bin/chromium"

# Stage budowania aplikacji
FROM base AS build

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      git \
      libyaml-dev \
      pkg-config

# Kopiowanie definicji gemów i instalacja z wykorzystaniem cache bundlera
COPY vendor/* ./vendor/
COPY Gemfile Gemfile.lock ./

RUN --mount=type=cache,target=/usr/local/bundle/cache \
    bundle install && \
    bundle exec bootsnap precompile -j 1 --gemfile

# Instalacja zależności Node.js (Puppeteer) bez pobierania binarnego Chromium
COPY package.json package-lock.json* ./
RUN PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm ci --omit=dev

# Kopiowanie kodu aplikacji
COPY . .

# Prekompilacja bootsnap oraz assetów
RUN bundle exec bootsnap precompile -j 1 app/ lib/
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Stage końcowy (odchudzony obraz produkcyjny)
FROM base

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash

RUN mkdir -p storage log tmp && \
    chown -R rails:rails storage log tmp

USER 1000:1000

COPY --chown=rails:rails --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --chown=rails:rails --from=build /rails /rails

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 80
CMD ["./bin/thrust", "./bin/rails", "server"]