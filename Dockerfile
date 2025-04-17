# Stage 1: Build Flutter web app
FROM debian:stable-slim AS builder

# Install minimal dependencies
RUN apt-get update && apt-get install -y curl git unzip libglu1-mesa-dev && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -u 1000 flutteruser
USER flutteruser
WORKDIR /home/flutteruser/app

# Install Flutter
ARG FLUTTER_VERSION=3.27.3
RUN git clone https://github.com/flutter/flutter.git /home/flutteruser/flutter -b ${FLUTTER_VERSION} \
    && /home/flutteruser/flutter/bin/flutter --version

# Copy and build app
COPY --chown=flutteruser:flutteruser . .
RUN /home/flutteruser/flutter/bin/flutter pub get \
    && /home/flutteruser/flutter/bin/flutter build web --release

# Stage 2: Serve with Nginx
FROM nginx:1.25-alpine
COPY --from=builder /home/flutteruser/app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]