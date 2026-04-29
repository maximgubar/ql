FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# --- base deps ---
RUN dpkg --add-architecture i386 && \
    apt update && apt install -y \
    wget \
    ca-certificates \
    xvfb \
    fluxbox \
    ffmpeg \
    lib32gcc-s1 \
    libstdc++6:i386 \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libglu1-mesa \
    libx11-6 \
    libxext6 \
    libxrandr2 \
    libxi6 \
    libxxf86vm1 \
    && rm -rf /var/lib/apt/lists/*

# --- install steamcmd ---
WORKDIR /steamcmd
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz

# --- try to install Quake Live (may fail in your env) ---
RUN ./steamcmd.sh +login anonymous \
    +force_install_dir /ql \
    +app_update 282440 validate \
    +quit || true

# --- runtime ---
-- WORKDIR /app
-- COPY start.sh /start.sh
-- RUN chmod +x /start.sh
