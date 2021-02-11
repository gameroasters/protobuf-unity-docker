FROM rust:1.49
LABEL maintainer="extrawurst"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    curl unzip protobuf-compiler
RUN mkdir /protobuf/
RUN curl -L https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protoc-3.14.0-linux-x86_64.zip --output /protobuf/protoc.zip
RUN unzip /protobuf/protoc.zip -d protobuf/protoc/
RUN cp protobuf/protoc/bin/protoc /usr/local/bin
RUN cargo install protobuf-codegen
RUN PATH="$HOME/.cargo/bin:$PATH"

# COPY ./rs-proto-generator/ /protobuf/rs-proto-generator/
# WORKDIR /protobuf/rs-proto-generator/
# RUN cargo build
# # RUN cp target/debug/rust-protobuf

# Generate .dll with all unity dependencies
# RUN dotnet new classlib -o /protobuf/Protobuf/
# RUN dotnet add /protobuf/Protobuf package Google.Protobuf --version 3.14.0
# RUN dotnet add /protobuf/Protobuf package System.Memory --version 4.5.4
# RUN dotnet add /protobuf/Protobuf package System.Buffers --version 4.5.1
# RUN dotnet add /protobuf/Protobuf package System.Runtime.CompilerServices.Unsafe --version 5.0.0
# RUN dotnet restore /protobuf/Protobuf
# RUN dotnet build -m:1 -o /protobuf/Protobuf/ "/protobuf/Protobuf/Protobuf.csproj"