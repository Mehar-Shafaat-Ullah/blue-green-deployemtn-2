# Use Node.js LTS image
FROM node:20

# Set working directory
WORKDIR /usr/src/app   # or ./app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app source
COPY . .

# Expose port 3000
EXPOSE 3000

# Default command
CMD ["node", "app.js"

