# protobuf-unity-docker

Cross platform functionality for `csharp` and `rust` [Protobuf](https://developers.google.com/protocol-buffers) file generation and extraction of `.dll` files for Unity.
Utilizes docker container.

### Requirements

- make
- docker

### Usage

1. Create [`.proto`](https://developers.google.com/protocol-buffers/) file
2. Generate `.rs` and `.cs` protobuf files using [protoc](https://github.com/protocolbuffers/protobuf/releases/tag/v3.14.0) with rust plugin
3. Download `.dll` files for use with Unity from [releases](https://github.com/kroonhorstdino/protobuf-unity/releases) or extract manually

### Commands

1. `make build` to setup docker image
2. Place `.proto` files, then `make pr-gen` to generate files in `proto/`
3. _Optional: `make pr-dlls` to extract `.dll` files into `dlls/`_
   - _`make pr-dlls-zip` to get a `.zip` file_

_OR_

2. `make pr-all` for both steps at once
