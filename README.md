# RESTful + Protobuf
This project is an attempt to demonstrate the usage of the protobuf protocol with RESTful API. The service is written in Go and two clients are provided in Javascript and Ruby.

## Prequisites
- Docker
- protoc (if you want to try compiling a protobuf file)

## Trying out the code
```sh
make build
# start the go server
make start-server
# run js client
make run-js
# run ruby client
make run-rb
# run both clients (js then ruby)
make run
```

## Compiling a protobuf file

Remove and regenerate protobuf files.
```sh
make clean-proto
make proto
```

See more details of the command used in the [Makefile](https://github.com/vtno/restful-protobuf/blob/master/Makefile) and view available options with `protoc --help`
