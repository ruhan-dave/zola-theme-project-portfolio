# use the alpine linux container as the basis
FROM alpine

# install the zola executable into the container
RUN apk add zola

# install libc compatibility for tailwindcss
RUN apk add libc6-compat

# install the tailwindcss executable into the container
ARG TAILWIND_VERSION=3.4.10
RUN wget https://github.com/tailwindlabs/tailwindcss/releases/download/v${TAILWIND_VERSION}/tailwindcss-linux-x64 -O /usr/local/bin/tailwindcss \
    && chmod +x /usr/local/bin/tailwindcss
