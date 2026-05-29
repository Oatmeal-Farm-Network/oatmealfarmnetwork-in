# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL
RUN npm run build

# Serve stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
# nginx:alpine omits application/manifest+json; patch it into the system mime.types
RUN sed -i '/text\/html/i\    application\/manifest+json    webmanifest;' /etc/nginx/mime.types
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
