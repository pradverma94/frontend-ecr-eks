FROM nginx
COPY index.html /usr/share/nginx/html
ENV HOST_A "localhost:1111"

