if ENVIRONMENT == 'development'
  # Enable pusher logging
  Pusher.log = (message) ->
    window.console.log(message)  if (window.console && window.console.log)

  # Flash fallback logging
  WEB_SOCKET_DEBUG = true

pusher  = new Pusher PUSHER_KEY
channel = pusher.subscribe 'test_channel'
channel.bind 'ping', (data)->
  $td_query_string = $('<td></td>')
  $.each data['rack.request.query_hash'], (index, value)->
    $td_query_string
      .append(' <span class="param-name">' + index + '</span> ')
      .append(' <span class="param-value">' + value + '</span> ')
  debugger

  $tr_summary = $('<tr class="summary"></tr>')
  $tr_summary
    .append("<td>" + data.PATH_INFO + "</td>")
    .append($td_query_string)
    .append("<td>" + data.REMOTE_ADDR + "</td>")
    .append("<td>" + data.HTTP_COOKIE + "</td>")
    .append('<td><a href="#" class="more">more</a></td>')
  debugger

  $tr_details = $('<tr class="details"></tr>')
  $tr_details
    .append('<td colspan="4">' + JSON.stringify(data) + '</td>')
    .append('<td></td>')
  debugger

  $("table#main tbody")
    .append($tr_summary)
    .append($tr_details)

$(document).ready ()->
  $("table#main a.more").live 'click', ()->
    $(this).closest("tr").next("tr.details").toggle()
