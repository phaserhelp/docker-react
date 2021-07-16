FROM node:alpine as builder
#USER node
WORKDIR '/app'
COPY package.json .
RUN npm install
# https://github.com/nodejs/docker-node/issues/971
#USER node
#RUN mkdir /app/node_modules/
#WORKDIR '/app'
#COPY --chown=node:node
COPY . .
#RUN chown -R node:node /app/node_modules
#RUN chmod -R 744 /app/node_modules
RUN npm run build


# TODO nginx configs
#/app/build/* has the code we want
FROM nginx
# copy from phase builder
COPY --from=builder /app/build /usr/share/nginx/html
