if ENVIRONMENT == 'development'
  # Enable pusher logging
  Pusher.log = (message) ->
    window.console.log(message)  if (window.console && window.console.log)

  # Flash fallback logging
  WEB_SOCKET_DEBUG = true

pusher  = new Pusher PUSHER_KEY
channel = pusher.subscribe 'test_channel'
channel.bind 'ping', (data)->
  $tr = $("<tr></tr>")
  $tr.append("<td>" + data.PATH_INFO + "</td>")
  $tr.append("<td>" + data.QUERY_STRING + "</td>")
  $tr.append("<td>" + data.REMOTE_ADDR + "</td>")
  $tr.append("<td>" + data.HTTP_COOKIE + "</td>")
  $("table#main tbody").append($tr)