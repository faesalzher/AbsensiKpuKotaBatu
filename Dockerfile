# =========================
# 1. BUILD STAGE
# =========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy entire repository
COPY . .

# Restore
RUN dotnet restore "./AbsensiKpuKotaBatu.API/AbsensiKpuKotaBatu.API.csproj"

# Publish
RUN dotnet publish "./AbsensiKpuKotaBatu.API/AbsensiKpuKotaBatu.API.csproj" -c Release -o /app/publish

# =========================
# 2. RUNTIME STAGE
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

# Render uses PORT=10000
ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

ENTRYPOINT ["dotnet", "AbsensiKpuKotaBatu.API.dll"]
