# protobuf-unity

Cross platform functionality for `csharp` and `rust` [Protobuf](https://developers.google.com/protocol-buffers) file generation and extraction of `.dll` files for Unity.

### Requirements

- make
- docker

### Usage

1. Create [`.proto`](https://developers.google.com/protocol-buffers/docs/) file
2. Generate `.rs` and `.cs` protobuf files using [protoc](https://github.com/protocolbuffers/protobuf/releases/tag/v3.14.0) inside docker container
3. Download `.dll` files for use with Unity from [releases]() or extract manually

### Example steps

1. `make build` to setup docker image
2. Place `.proto` file, then `make pr-gen proto=<PROTO_FILE>` to generate files in `proto/`
3. _Optional: `make pr-dlls` to extract `.dll` files into `dlls/`_

_OR_

2. `make pr-all proto=<PROTO_FILE>` for both steps at once
