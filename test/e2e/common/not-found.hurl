# Not found
GET {{base}}/example/foobar/not-found.json
HTTP 404
Content-Type: application/json
[Captures]
current_request_id: header "X-Request-id"
[Asserts]  
jsonpath "$.code" == 404
jsonpath "$.error" == "not-found"
jsonpath "$.message" == "There is no schema at this URL"
jsonpath "$.request" == "{{current_request_id}}"

# Not found on directory
GET {{base}}/example/schemas.json
HTTP 404
Content-Type: application/json
[Captures]
current_request_id: header "X-Request-id"
[Asserts]
jsonpath "$.code" == 404
jsonpath "$.error" == "not-found"
jsonpath "$.message" == "There is no schema at this URL"
jsonpath "$.request" == "{{current_request_id}}"
