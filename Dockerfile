# Stage 1: Build Flutter web app
FROM debian:stable-slim AS builder

# Install dependencies (ARM64 compatible)
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip libglu1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -u 1000 flutteruser
USER flutteruser
WORKDIR /home/flutteruser/app

# Install Flutter (v3.27.3)
ARG FLUTTER_VERSION=3.27.3
RUN git clone https://github.com/flutter/flutter.git /home/flutteruser/flutter -b ${FLUTTER_VERSION}
ENV PATH="$PATH:/home/flutteruser/flutter/bin:/home/flutteruser/flutter/bin/cache/dart-sdk/bin"

# Verify versions
RUN flutter --version

# Copy and build ScrapIt
COPY --chown=flutteruser:flutteruser . .
RUN flutter pub get && flutter build web --release

# Stage 2: Serve with Nginx — named as final
FROM nginx:1.25-alpine AS final
COPY --from=builder /home/flutteruser/app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]