require 'google/protobuf'
require 'httparty'
require './proto/hello_pb'

first_name = "tino"
last_name = "tham"
metadata = Hello::Metadata.new(f_name_letter_count: first_name.size, l_name_letter_count: last_name.size)
hello_request = Hello::HelloRequest.new(first_name: first_name, last_name: last_name, metadata: metadata)

p "Sending buffer: #{Hello::HelloRequest.encode(hello_request)}"

class HttpClient
  include HTTParty

  base_uri "http://localhost:8080"
end

opts = { 
  body: Hello::HelloRequest.encode(hello_request)
}

resp = HttpClient.post "/hello", opts

p Hello::HelloResponse.decode resp.body