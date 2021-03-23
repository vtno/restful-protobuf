build-server:
	docker build -t hello-server -f ./server/Dockerfile.server ./server/

build-js-client:
	docker build -f clients/js/Dockerfile.js -t js-client ./clients/js/

build-rb-client:
	docker build -f clients/ruby/Dockerfile.rb -t js-client ./clients/ruby/

clean-proto:
	rm clients/js/proto/* clients/ruby/proto/* server/proto/*.go

go-proto:
	protoc -I. hello.proto --go_out=./server/

ruby-proto:
	protoc -I. hello.proto --ruby_out=./clients/ruby/proto

js-proto:
	protoc -I. hello.proto --js_out=import_style=commonjs,binary:./clients/js/proto

proto: go-proto ruby-proto js-proto

build: build-server build-js-client build-rb-client

run-js: build-js-client
	docker run js-client

run-rb: build-rb-client
	docker run ruby-client

start-server: build-server
	docker run -p 8080:8080 hello-server

stop-server:
	docker stop $$(docker ps | grep hello-server | awk -F ' ' '{print $$1}')
 
run: run-js run-rb