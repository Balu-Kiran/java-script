# Step 1: Use NGINX Base Image
FROM nginx:alpine

# Step 2: Install required tools
RUN apk update && apk add --no-cache unzip

# Step 3: Accept the artifact as a build argument
ARG ARTIFACT_FILE=react-build.zip

# Step 4: Copy the pre-downloaded artifact from the build context
COPY ${ARTIFACT_FILE} /tmp/react-build.zip

# Step 5: Unzip the artifact
RUN unzip /tmp/react-build.zip -d /tmp/react-build

# Step 6: Copy build files to NGINX HTML directory
RUN rm -rf /usr/share/nginx/html/* && \
    cp -r /tmp/react-build/build/* /usr/share/nginx/html/

# Step 7: Expose port 80
EXPOSE 80

# Step 8: Start NGINX
CMD ["nginx", "-g", "daemon off;"]
