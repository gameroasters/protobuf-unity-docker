FROM rust:1.49
LABEL maintainer="extrawurst"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    curl unzip zip protobuf-compiler

RUN mkdir /protobuf/
WORKDIR /protobuf/

### ==== Install protoc ====

### Install protoc binary 
RUN curl -L https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protoc-3.14.0-linux-x86_64.zip --output protoc.zip && \
    unzip protoc.zip -d protoc/ && \
    cp -r protoc/ /usr/local/bin
RUN rm -rf protoc/ && rm protoc.zip

# with rust plugin
RUN cargo install protobuf-codegen
RUN PATH="$HOME/.cargo/bin:$PATH"

### ==== DLL Extraction ====
RUN mkdir -p /protobuf/nuget/ 
RUN mkdir -p /protobuf/dlls/
WORKDIR /protobuf/nuget/

#Get NuGet packages
ARG nuget_url=https://www.nuget.org/api/v2/package
RUN curl -L ${nuget_url}/Google.Protobuf/3.14.0 --output google.protobuf.zip && \
    curl -L ${nuget_url}/System.Memory/4.5.4 --output system.memory.zip && \
    curl -L ${nuget_url}/System.Buffers/4.5.1 --output system.buffers.zip && \
    curl -L ${nuget_url}/System.Runtime.CompilerServices.Unsafe/5.0.0 --output system.runtime.compilerServices.unsafe.zip
RUN unzip google.protobuf.zip -d google.protobuf/ && \
    unzip system.memory.zip -d system.memory/ && \
    unzip system.buffers.zip  -d system.buffers/ && \
    unzip system.runtime.compilerServices.unsafe.zip -d system.runtime.compilerServices.unsafe/
ARG dll_path=lib/netstandard2.0
RUN cp google.protobuf/${dll_path}/Google.Protobuf.dll ../dlls/Google.Protobuf.dll && \
    cp system.memory/${dll_path}/System.Memory.dll ../dlls/System.Memory.dll && \
    cp system.buffers/${dll_path}/System.Buffers.dll ../dlls/System.Buffers.dll && \
    cp system.runtime.compilerServices.unsafe/${dll_path}/System.Runtime.CompilerServices.Unsafe.dll ../dlls/System.Runtime.CompilerServices.Unsafe.dll
WORKDIR /
RUN rm -rf /protobuf/nuget/