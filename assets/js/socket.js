// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import { Socket, Presence } from 'phoenix'

let id;

if (localStorage.getItem('chat_id')) {
  id = localStorage.getItem('chat_id')
} else {
  id = Math.floor(Math.random() * 2000);
  localStorage.setItem("chat_id", id);
}

let socket = new Socket("/socket", {params: {user:  id }})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

let presences = {}

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("chat:lobby", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

let messageInput = document.getElementById("input")
let messageSend = document.getElementById("send")

if (messageInput) {
  messageInput.addEventListener("keypress", (e) => {
    if (e.keyCode == 13 && messageInput.value != "") {
      channel.push("message:new", messageInput.value)
      messageInput.value = ""
    }
  })
  messageSend.addEventListener("click", (e) => {
    if (messageInput.value != "") {
      channel.push("message:new", messageInput.value)
      messageInput.value = ""
    }
  })
}

let formatTimestamp = (timestamp) => {
  let date = new Date(timestamp)
  return date.toLocaleTimeString()
}

let messageList = document.getElementById("messages")
let renderMessage = (message) => {
  let messageElement = document.createElement("li")
  messageElement.innerHTML = `
    <i>${formatTimestamp(message.timestamp)}</i>
    <span><b>${message.body}</b></span>
  `
  messageList.insertBefore(messageElement, messageList.firstChild );
  messageList.scrollTop = messageList.scrollHeight;
}


channel.on("message:new", message => renderMessage(message))

channel.on("presence_state", state => {
  presences = Presence.syncState(presences, state)
  console.log(Object.keys(presences).length)
  document.getElementById('online').innerHTML = Object.keys(presences).length
})

channel.on("presence_diff", diff => {
  presences = Presence.syncDiff(presences, diff)
  document.getElementById('online').innerHTML = Object.keys(presences).length
})

export default socket
