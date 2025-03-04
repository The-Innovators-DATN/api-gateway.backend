docker run -e KONG_DATABASE=postgres \
  -e KONG_PG_HOST=160.191.49.50 \
  -e KONG_PG_PORT=5432 \
  -e KONG_PG_USER=kong \
  -e KONG_PG_PASSWORD=asd123 \
  -e KONG_PG_DATABASE=kong \
  kong/kong-gateway:3.9.0.1 kong migrations bootstrap

docker run -d --name kong \
    --network=host \
    -e KONG_DATABASE=postgres \
    -e KONG_PG_HOST=160.191.49.50 \
    -e KONG_PG_PORT=5432 \
    -e KONG_PG_USER=kong \
    -e KONG_PG_PASSWORD=asd123 \
    -e KONG_PG_DATABASE=kong \
    -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
    -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
    -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
    -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
    -e "KONG_ADMIN_LISTEN=0.0.0.0:8001" \
    -e "KONG_ADMIN_GUI_URL=http://160.191.49.128:8002" \
    -p 8000:8000 \
    -p 8001:8001 \
    -p 8444:8444 \
    -p 8002:8002 \
    kong/kong-gateway:3.9.0.1

curl -i -X POST http://localhost:8001/consumers/user1@example.com/oauth2 \
  --data "name=GoogleOAuth" \
  --data "client_id=759159252498-1tu1ben7amd25d8dfm2kljd3u05683i3.apps.googleusercontent.com" \
  --data "client_secret=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" \
  --data "redirect_uris[]=https://example.com/auth/callback"
