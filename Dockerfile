FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
# No need to specify CMD because nginx image already has a default CMD
# we do not need to explicitly specify it this is an optional step
ENTRYPOINT [ "nginx" , "-g" , "daemon off;" ]
