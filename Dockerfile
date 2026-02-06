# -------- BUILD STAGE --------
FROM debian:bullseye-slim AS build

# Install required packages
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable web
RUN flutter doctor
RUN flutter config --enable-web

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Get dependencies & build web
RUN flutter pub get
RUN flutter build web

# -------- RUNTIME STAGE --------
FROM nginx:alpine

# Copy Flutter web build to nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
