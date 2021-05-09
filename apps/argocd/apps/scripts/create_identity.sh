curl --request POST -sL \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{
  "schema_id": "default",
  "traits": {
    "email": "locmai0201@gmail.com",
    "username": "locmai"
  }
}' \
    http://localhost:4434/identities

curl --request POST -sL \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{
  "expires_in": "12h",
  "identity_id": "35e8e812-c211-45b2-b6d1-c5ad58572b81"
}' \
    http://localhost:4434/recovery/link

curl --request GET -sL \
    --header "Content-Type: application/json" \
    --request GET \
    http://localhost:4434/schemas/default