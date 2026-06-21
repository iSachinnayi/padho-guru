# पढ़ो गुरु — Genkit Server Dockerfile for Cloud Run
FROM dart:stable AS build

WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart run build_runner build -d
RUN dart compile exe bin/server.dart -o bin/server

# Minimal runtime image
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

CMD ["/app/bin/server"]
