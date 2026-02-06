# -------------------------------
# Stage 1: Build Flutter Web App
# -------------------------------
FROM cirrusci/flutter:stable AS build

WORKDIR /app

# Copy files
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .

# Build web app
RUN flutter build web --release

# -------------------------------
# Stage 2: Serve with Nginx
# -------------------------------
FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build output
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

