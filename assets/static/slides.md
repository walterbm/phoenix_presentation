# Phoenix Framework Presentation

## Introduction

- Phoenix is a web development framework written in Elixir
- Uses the classic MVC pattern
- At a high level the architecture is very similar to Rails, Django, Laravel, etc.

## Goal

- High developer productivity (ample use of REST generators)
- High application performance (use the Erlang VM and native concurrency)
- Lower the barrier for real-time applications (e.g. chat)

## History

- Created by former Rails Core members to address flaws in Rails
- Take what made Rails great and update it for modern applications
- **Phoenix** _get it?_

## What do you get

- Tons of generators (0 to REST in 5min)
- ORM that learns from the mistakes of Active Record (_Ecto_)
- Excellent routing & middleware (_Plug_)
- Server-side templating (for monolith fun)

## What do you get

- Unit and integration testing (_ExUnit_)
- Great tooling (debugger, logger, etc. )
- Hot upgrade deployments
- The compiler prevents a lot of mistakes

## Quick Tour

`router.ex`

```elixir
get "/presentation", PresentationController, :index
```

## Quick Tour

`presentation_controller.ex`

```elixir
def index(conn, params) do
  number = Map.get(params, "slide", "0") |> String.to_integer
  slide = Markdown.convert_slide(@slides, number)
  render conn, "slide.html", slide: slide
end
```

## Quick Tour

`slide.html.ex`

```elixir
<div class="slide">
  <%= raw @slide %>
</div>
```

## Advantages

- Same old REST framework with concurrency (_more cores is more better_)
- Extremely high reliability and availability (the power of Erlang)
- Real-time applications are easy to build and reason about
- Fast

## I wanna go FAST

- Rails throughput ≈ 12000 req/s
- Express Cluster  ≈ 92000 req/s
- Phoenix          ≈ 180000 req/s

## Binary deployments

- Generate a single binary to deploy
- Encapsulates Erlang, BEAM, Elixir, and your app

## Disadvantages

- Not as mature as Rails, Django, Laravel
- No tech giant to follow (only B/R)
- Real overhead to learning depths of functional programing

## Demos

- Chat is easy
- Server side rendeing is incredibly fast
- This whole thing is a demo

## Chat

`endpoint.ex`

```elixir
socket "/socket", PhoenixPresentation.Web.UserSocket
```

## Chat

`user_socket.ex`

```elixir
channel "chat:lobby", PhoenixPresentation.Web.ChatChannel

def connect(%{"user" => user}, socket) do
  {:ok, assign(socket, :user, user)}
end
```

## Chat

`chat_channel.ex`

```elixir
def handle_in("message:new", message, socket) do
  broadcast! socket, "message:new", %{
    body: message,
    timestamp: :os.system_time(:milli_seconds)
  }
  {:noreply, socket}
end
```

## Chat

`chat_channel.ex`

```elixir
def handle_info(:after_join, socket) do
  Presence.track(socket, socket.assigns.user, %{
    online_at: :os.system_time(:milli_seconds)
  })
  push socket, "presence_state", Presence.list(socket)
  {:noreply, socket}
end
```

## Real World Problems

- *Slow requests?*
- Could use an external queue
- Or use Async/Await, elixir processes, and VM scheduling

## Real World Problems

- *Need chat and realtime functionality?*
- Phoenix Channels make it incredibly easy
- Use tested abstractions over OTP patterns and Erlang pub-sub
- Proven to handle 10k concurrent across machines without Redis

## Real World Problems

- *Traffic spikes?*
- Each request is an isolated process
- Ask Kelvin about his load tests

## Real World Problems

- *Need some NoSQL for some quick cacheing?*
- Erlang BEAM comes with ETS and Mnesia

## End

- Phoenix is really no different than Rails, Django, Larvel
- You can be productive without diving into the depths of functional programming
- Great for an internal projects
- Kelvin picked it up in two weeks
