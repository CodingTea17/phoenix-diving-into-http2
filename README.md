# Diving Into Http2
A slightly modified phoenix template that utilizes the HTTP/2 protocol to serve static content.

The project was created with: `mix phx.new --no-brunch --no-ecto http2_test`

Replaced deps inside of mix.exs with:

```
defp deps do
  [
    {:phoenix, git: "https://github.com/phoenixframework/phoenix", branch: "master", override: true},
    {:plug, git: "https://github.com/elixir-plug/plug", branch: "master", override: true},
    {:phoenix_pubsub, "~> 1.0"},
    {:phoenix_html, "~> 2.10"},
    {:phoenix_live_reload, "~> 1.0", only: :dev},
    {:gettext, "~> 0.11"},
    {:cowboy, "~> 2.1", override: true},
  ]
end
```
Ran `openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -keyout priv/server.key -out priv/server.pem` inside the project directory to generate self-signed ssl certs. (server.key && server.pem were added to .gitignore)

Update the endpoint in `config/dev.exs` to use https and specify the Cowboy2Apdater:
```
config :diving_into_http2, DivingIntoHttp2Web.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []
```
turns into this:
```
config :diving_into_http2, DivingIntoHttp2Web.Endpoint,
  https: [port: 4000, keyfile: "priv/server.key", certfile: "priv/server.pem"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](https://localhost:4000) from your browser.

Inside the Chrome Dev Tools you can see h2 listed as the protocol used
![Chrome Dev Tools protocol screenshot](readme_images/chrome_dev_tools_h2.png?raw=true "Chrome Dev Tools h2 protocol")

I've read http/2 doesn't play nice with websockets (something about hogging the entire TCP connection) and I think this error might have something to do with... If anyone happens to know for sure, please let tell me all about it!
![Some error screenshot](readme_images/some_error.png?raw=true "An error that kept occurring")

Shout out to Maarten van Vliet for providing an article about making the upgrade (the only modification needed was to change `handler: Phoenix.Endpoint.Cowboy2Handler,` to `adapter: Phoenix.Endpoint.Cowboy2Adapter,`). Here's a link to his [terrific article](https://maartenvanvliet.nl/2017/12/15/upgrading_phoenix_to_http2/)! 
