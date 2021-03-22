package main

import (
	// "fmt"
	"fmt"
	"log"
	"net/http"
	"io/ioutil"

	pb "github.com/vtno/restful-protobuf/server/proto"
	"google.golang.org/protobuf/proto"
)

func hello(w http.ResponseWriter, req *http.Request) {
	body, err := ioutil.ReadAll(req.Body)
	if err != nil {
		log.Fatalln("Failed to read HelloRequest", err)
	}

	log.Printf("receiving: %v", body)

	helloRequest := &pb.HelloRequest{}
	err = proto.Unmarshal(body, helloRequest)
	if err != nil {
		log.Fatalln("Failed to parse HelloRequest", err)
	}

	fullName := helloRequest.GetFirstName() + " " + helloRequest.GetLastName()
	helloResponse := &pb.HelloResponse{
		FullName: fullName,
		Metadata: &pb.Metadata{
			FNameLetterCount: helloRequest.GetMetadata().GetFNameLetterCount(),
			LNameLetterCount: helloRequest.GetMetadata().GetLNameLetterCount(),
		},
	}

	log.Printf("%v", helloResponse)
	resp, err:= proto.Marshal(helloResponse)
	if err != nil{
		log.Fatalln("Failed to serialize HelloResponse", err)
	}

	log.Printf("sending: %v", resp)
	// Need to convert response to string to avoid byte[] format issue
	fmt.Fprint(w, string(resp))
}

func main() {
	http.HandleFunc("/hello", hello)

	log.Println("Listening on port 8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
