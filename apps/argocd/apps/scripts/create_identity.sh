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
  "identity_id": "83959fbc-f7a2-4a30-a76f-1737c69b366d"
}' \
    http://localhost:4434/recovery/link

curl --request GET -sL \
    --header "Content-Type: application/json" \
    --request GET \
    http://localhost:4434/schemas/default