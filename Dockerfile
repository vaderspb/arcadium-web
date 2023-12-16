FROM node:21-alpine AS builder

WORKDIR /arcadium

COPY package.json package.json

RUN npm install

COPY public public
COPY src src
COPY tsconfig.json .

RUN npm run build


FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf *

COPY --from=builder /arcadium/build .

ENTRYPOINT ["nginx", "-g", "daemon off;"]
