# पढ़ो गुरु — Genkit Server Dockerfile for Cloud Run
FROM dart:stable AS build

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart compile exe bin/server.dart -o bin/server

# Debian-based runtime for Dart AOT executable
FROM debian:stable-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build /app/bin/server /app/bin/server

EXPOSE 3400
ENV PORT=3400
CMD ["/app/bin/server"]
