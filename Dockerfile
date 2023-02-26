# Pull the node image from docker
FROM node:14.20.0-alpine as builder
# Specify a work directory where we install the dependencies
WORKDIR /app
# Copy the package.json and package-lock.json together to the work directory
COPY package.json package-lock.json ./
# Install the required dependencies
RUN npm install
# Copy the rest of the files to the working directory
COPY . .
# Run the build
RUN npm run build

FROM nginx:stable-alpine

WORKDIR usr/share/nginx/html

RUN rm -rf ./* 

COPY --from=builder /app/build ./

EXPOSE 80

CMD ['nginx', '-g', 'daemon off;']

