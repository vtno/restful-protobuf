module github.com/vtno/restful-protobuf/server

go 1.16

replace github.com/vtno/restful-protobuf/server/proto => ./proto

require (
	github.com/vtno/restful-protobuf/server/proto v1.0.0
	google.golang.org/protobuf v1.26.0
)
