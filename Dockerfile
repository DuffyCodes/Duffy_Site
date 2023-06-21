# Stage 1: Build the Angular app
FROM node:18.16-bullseye as build

WORKDIR src/app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Stage 2: Serve the Angular app
FROM nginx:1.21.0-alpine

COPY --from=build src/app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
