FROM hugomods/hugo:exts AS builder

WORKDIR /src
ARG HUGO_BASEURL
ENV HUGO_BASEURL=${HUGO_BASEURL}

COPY . .

RUN hugo --minify -b "${HUGO_BASEURL}"

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy Hugo output
COPY --from=builder /src/public /usr/share/nginx/html
# Copy our nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]