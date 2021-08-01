FROM dart:stable AS build

WORKDIR /project/server

# Add the pubspec.yaml files for each local package.
ADD shared/pubspec.yaml /project/shared/

# Template for adding the application and local packages.
ADD server/pubspec.* /project/server/
RUN pub get
ADD . /project
RUN pub get --offline
RUN dart compile exe bin/flow_server.dart -o bin/flow_server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /project/server/bin/flow_server /server/bin/

# Start server.
EXPOSE 3000
CMD ["/server/bin/flow_server"]