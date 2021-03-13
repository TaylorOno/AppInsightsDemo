FROM mcr.microsoft.com/dotnet/aspnet:2.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:2.1 AS build
WORKDIR /src
COPY ["AppInsightsDemo.csproj", "."]
RUN dotnet restore "AppInsightsDemo.csproj"
COPY . .
RUN dotnet build "AppInsightsDemo.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "AppInsightsDemo.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "AppInsightsDemo.dll"]
