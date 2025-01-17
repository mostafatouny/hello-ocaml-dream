# Build Stage
# # # # #

# base image
FROM ocaml/opam:alpine AS build

# install os dependencies
RUN sudo apk add --no-cache --update libev libev-dev openssl-dev gmp-dev sqlite-dev sqlite-libs

# create app directory
WORKDIR /usr/home/app

# Install dependencies
COPY req.opam req.opam
RUN opam install . --deps-only

# Build project
COPY . .
RUN opam exec -- dune build


# Run Stage
# # # # #

# base image
FROM alpine:3.18.4 AS run

# update os
RUN apk add --no-cache --update libev sqlite-dev sqlite-libs

# copy binary
COPY --from=build /usr/home/app/_build/default/main.exe /bin/app

# metadata port of dream
EXPOSE 8080

# execute binary upon container start
ENTRYPOINT [ "/bin/sh", "-c", "/bin/app" ]
