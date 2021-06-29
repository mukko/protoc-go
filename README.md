# protoc-go docker

protoc container for golang.

This container can use options as for `protoc` command are available.  

**important**  
This container runs in the `/defs` directory. You have to mount .proto files at `/defs`.

## Options

`-h` : print help.  
`-d <string>` : generate all proto files in a directory.  
`-o <string>` : add all output to a directory. If not specified, output to `gen/pb-go` directory.  
`--go_opt <string>` : protoc go option.  

## Usage

help:  

```bash
docker run --rm mukko/protoc-go:latest -h
```

example:  

```bash
docker run --rm -v "$PWD":/defs mukko/protoc-go:latest -d protos -o outputs --go_opt module=hogefuga
```
