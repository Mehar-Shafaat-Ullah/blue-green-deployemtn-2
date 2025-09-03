#!/bin/bash
# we need jsut to run thsi
# Detect active port from Nginx upstream
ACTIVE_PORT=$(grep -oP 'server\s+127\.0\.0\.1:\K[0-9]+' /etc/nginx/sites-available/app.conf)

if [ "$ACTIVE_PORT" = "3001" ]; then
    NEW_PORT=3002
    CONTAINER_NAME="app-green"
    APP_IMAGE="myapp-green"
    APP_COLOR="Green"
    echo "Switching to Green container on port $NEW_PORT"
else
    NEW_PORT=3001
    CONTAINER_NAME="app-blue"
    APP_IMAGE="myapp-blue"
    APP_COLOR="Blue"
    echo "Switching to Blue container on port $NEW_PORT"
fi

# Start container if not running
if [ -z "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    docker run -d --name $CONTAINER_NAME -p $NEW_PORT:3000 -e APP_COLOR=$APP_COLOR $APP_IMAGE
fi

# Update Nginx upstream reliably
sudo sed -i "s/server\s\+127\.0\.0\.1:[0-9]\+/server 127.0.0.1:$NEW_PORT/" /etc/nginx/sites-available/app.conf

# Reload Nginx
sudo nginx -t && sudo systemctl reload nginx

echo "Switched traffic to $CONTAINER_NAME on port $NEW_PORT"

