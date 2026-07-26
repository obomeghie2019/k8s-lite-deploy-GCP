FROM nginx:1.27-alpine

# Remove default nginx site config
RUN rm /etc/nginx/conf.d/default.conf

# Add our custom config (defines /health + serves on port 3000)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the static site
COPY src/ /usr/share/nginx/html/

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]