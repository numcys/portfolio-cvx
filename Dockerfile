# Use a lightweight Node.js image
FROM node:lts-slim AS build-stage

# Set working directory
WORKDIR /app

# Copy package.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code
COPY . .

# Build the application for production (assuming a build script)
RUN npm run build

# Switch to a non-root user
USER node

# Define a slim image for production
FROM node:lts-slim

# Copy the production build from the build stage
COPY --from=build-stage /app/dist /app/dist

# Expose the port (replace 3000 with your app's port)
EXPOSE 3000
