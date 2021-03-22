build-server:
	docker build -t hello-server -f Dockerfile.server .

start-server: build-server
	docker run -p 8080:8080 hello-server

clean-proto:
	rm clients/js/proto/* clients/ruby/proto/* server/proto/*.go

go-proto:
	protoc -I. hello.proto --go_out=./server/

ruby-proto:
	protoc -I. hello.proto --ruby_out=./clients/ruby/proto

js-proto:
	protoc -I. hello.proto --js_out=import_style=commonjs,binary:./clients/js/proto

proto: go-proto ruby-proto js-proto