# Stage 1: Build Stage
FROM node:slim AS build
WORKDIR /dante-pet-club.frontend/
COPY . .
RUN npm install -g @quasar/cli
RUN npm install
RUN quasar build

RUN npm install
RUN quasar build

# Stage 2: Final Stage
FROM nginx:1.25.3-alpine3.18 AS production-stage
COPY --from=build /dante-pet-club.frontend/dist/spa/ /usr/share/nginx/html
COPY nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
