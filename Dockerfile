# Use Linux-based images instead of Windows-based ones
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine AS base
WORKDIR /app
EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080

FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build
ARG configuration=Release
WORKDIR /src
COPY ["HelloWorldApp.csproj", "./"]
RUN dotnet restore "HelloWorldApp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "HelloWorldApp.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "HelloWorldApp.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]
