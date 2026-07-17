FROM nginx:alpine

# Remove the default site
RUN rm -rf /usr/share/nginx/html/*

# Copy our nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]