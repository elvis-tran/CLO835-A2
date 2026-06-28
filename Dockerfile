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