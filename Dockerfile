FROM --platform=${BUILDPLATFORM} docker.io/node:alpine as builder
RUN apk add --no-cache git python3 build-base
COPY . /app
WORKDIR /app
RUN yarn install \
 && yarn build

FROM --platform=${TARGETPLATFORM} docker.io/nginx:alpine
COPY --from=builder /app/target /usr/share/nginx/html
