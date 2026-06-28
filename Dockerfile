# TODO: Build a container image for your chosen starter app.
# Requirement: the image must run your app and serve on port 8080.
# Tip: use the files from apps/<your-language>/.

# FROM <choose a base image for your language>
# WORKDIR /app
# COPY . .
# RUN <build your app, if it needs a build step>
# EXPOSE 8080
# CMD ["<command that starts your app>"]

FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY apps/csharp/*.csproj ./apps/csharp/
RUN dotnet restore "apps/csharp/"

COPY apps/csharp/ ./apps/csharp/
WORKDIR /src/apps/csharp
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/runtime:10.0 AS runtime
WORKDIR /app

EXPOSE 8080

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "server.dll"]