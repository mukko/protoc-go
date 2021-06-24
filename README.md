# protoc-go docker

protoc container for golang.

This container can use options as for `protoc` command are available.  

**important**  
This container runs in the `/defs` directory. You have to mount .proto files at `/defs`.

## Usage

help:  

```bash
docker run --rm mukko/protoc-go:latest -h
```

example:  

```bash
docker run --rm -v "$PWD":/defs mukko/protoc-go:latest -I=pb --go_out=model pb/*.proto
```
