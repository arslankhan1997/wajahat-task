upstream backend_servers {
    server 192.168.1.2:5000 max_fails=3 fail_timeout=10s;
    server 192.168.1.3:5000 max_fails=3 fail_timeout=10s;
}

server {
    listen 80;

    location / {
        proxy_pass http://backend_servers;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Serve static files
    location /static/ {
        root /var/www/html;
    }

    # Custom error pages
    error_page 404 /custom_404.html;
    error_page 500 502 503 504 /custom_50x.html;
    
    location = /custom_404.html {
        root /var/www/html;
    }

    location = /custom_50x.html {
        root /var/www/html;
    }

    # Enable Gzip compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
