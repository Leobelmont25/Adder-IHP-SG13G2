# Base image
FROM ubuntu:22.04

# Definir variáveis de ambiente
ENV DEBIAN_FRONTEND=noninteractive



# Atualizar e instalar dependências básicas
RUN apt-get update && apt-get install -y \
    sudo \
    apt-utils \
    software-properties-common \
    ssh \
    git \
    curl \
    time \
    libtool-bin \
    libqt5core5a \
    libqt5gui5 \
    libqt5designer5 \
    libqt5charts5 \
    tcl-tclreadline \
    libqt5multimedia5 \
    libqt5multimediawidgets5 \
    libqt5network5 \
    libqt5opengl5 \
    libqt5printsupport5 \
    libqt5sql5 \
    libqt5svg5 \
    libqt5widgets5 \
    libqt5xml5 \
    libqt5xmlpatterns5 \
    zlib1g \
    autotools-dev \
    automake \
    pkg-config \
    libyaml-dev \
    libssl-dev \
    gdb \
    ninja-build \
    flex \
    bison \
    libfl-dev \
    cmake \
    libgit2-dev \
    libftdi1-dev \
    python3 \
    python3-dev \
    python3-pip \
    python3-yaml \
    libpython3-dev \
    libpython3.8 \
    ruby \
    ruby-dev \
    virtualenv \
    openjdk-11-jdk-headless \
    verilator \
    gtkwave \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libtinfo5 \
    libx11-xcb1 \
    libxcb1 \
    libxcb-glx0 \
    libxcb-keysyms1 \
    libxcb-image0 \
    libxcb-shm0 \
    libxcb-icccm4 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxcb-shape0 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxrender1 \
    libxkbcommon-x11-0 \
    libglu1-mesa \
    libncurses5 \
    wget \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=""

# Instalação do oss-cad-suite (Yosys, etc)
RUN wget https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2024-07-17/oss-cad-suite-linux-x64-20240717.tgz && \
    tar -xvf oss-cad-suite-linux-x64-20240717.tgz && \
    rm oss-cad-suite-linux-x64-20240717.tgz && \
    mv oss-cad-suite /opt/oss-cad-suite && \
    echo 'export PATH=/opt/oss-cad-suite/bin:$PATH' >> /etc/profile.d/oss-cad-suite.sh && \
    echo 'export LD_LIBRARY_PATH=/opt/oss-cad-suite/lib:$LD_LIBRARY_PATH' >> /etc/profile.d/oss-cad-suite.sh

# Instalação do OpenROAD
RUN wget https://github.com/Precision-Innovations/OpenROAD/releases/download/2024-12-14/openroad_2.0-17598-ga008522d8_amd64-ubuntu-22.04.deb && \
    apt install ./openroad_2.0-17598-ga008522d8_amd64-ubuntu-22.04.deb && \
    rm openroad_2.0-17598-ga008522d8_amd64-ubuntu-22.04.deb

# Instalar Klayout
RUN apt-get update && apt-get install -y \
    qt5-qmake \
    qtbase5-dev \
    qtbase5-dev-tools \
    && rm -rf /var/lib/apt/lists/*
RUN wget https://www.klayout.org/downloads/Ubuntu-22/klayout_0.29.12-1_amd64.deb
RUN apt install ./klayout_0.29.12-1_amd64.deb && \
    rm klayout_0.29.12-1_amd64.deb
    

# Clonar OpenROAD-flow-scripts
RUN cd /opt && \
    git clone https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts.git && \
    cd OpenROAD-flow-scripts && \
    git checkout d617deb35b6823c03846bacfefbd838f49cff437


# Instalar IHP PDK
RUN git clone --progress https://github.com/IHP-GmbH/IHP-Open-PDK.git && \
    cd IHP-Open-PDK/ihp-sg13g2/libs.tech/klayout/python && \
    git clone https://github.com/IHP-GmbH/pypreprocessor.git && \
    git clone https://github.com/IHP-GmbH/pycell4klayout-api.git

# Instalar psutil python
RUN pip3 install psutil


# Define o PATH
ENV PATH="/opt/oss-cad-suite/bin:$PATH"
ENV LD_LIBRARY_PATH="/opt/oss-cad-suite/lib:$LD_LIBRARY_PATH"
RUN /opt/OpenROAD-flow-scripts/env.sh
ENV KLAYOUT_HOME="IHP-Open-PDK/ihp-sg13g2/libs.tech/klayout"
ENV YOSYS_CMD="/opt/oss-cad-suite/bin/yosys"
ENV YOSYS_EXE="/opt/oss-cad-suite/bin/yosys"
ENV OPENROAD_EXE="/usr/bin/openroad"
ENV OPENROAD_CMD="/usr/bin/openroad"

# Definir diretório de trabalho
WORKDIR /opt/OpenROAD-flow-scripts

# Comando padrão
CMD ["/bin/bash"]

